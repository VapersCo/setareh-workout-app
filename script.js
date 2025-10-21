// ==========================================
// Setareh's Workout App - JavaScript
// ==========================================

// ========== State Management ==========
let holdStartTime = null;
let holdCompleted = false;
let swipeStartY = null;
let currentPage = 'splash-screen';

// LocalStorage key
const STORAGE_KEY = 'setareh_workout_progress';

// ========== Utility Functions ==========

/**
 * Navigate to a different page
 */
function navigateTo(pageId) {
    // Hide all pages
    document.querySelectorAll('.page').forEach(page => {
        page.classList.remove('active');
    });

    // Show target page
    const targetPage = document.getElementById(pageId);
    if (targetPage) {
        targetPage.classList.add('active');
        currentPage = pageId;

        // If navigating to a workout day, render exercises and update progress
        if (pageId.startsWith('day')) {
            renderExercises(pageId);
            updateProgress(pageId);
        }
    }
}

/**
 * Get progress data from localStorage
 */
function getProgress() {
    const stored = localStorage.getItem(STORAGE_KEY);
    return stored ? JSON.parse(stored) : {};
}

/**
 * Save progress data to localStorage
 */
function saveProgress(progress) {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(progress));
}

/**
 * Check if an exercise is completed
 */
function isExerciseCompleted(exerciseId) {
    const progress = getProgress();
    return progress[exerciseId]?.completed || false;
}

/**
 * Toggle exercise completion
 */
function toggleExerciseCompletion(exerciseId) {
    const progress = getProgress();
    const today = new Date().toISOString().split('T')[0];

    if (progress[exerciseId]?.completed) {
        // Mark as incomplete
        progress[exerciseId] = { completed: false };
    } else {
        // Mark as complete
        progress[exerciseId] = { completed: true, lastDate: today };
    }

    saveProgress(progress);

    // Update the UI
    const exerciseCard = document.querySelector(`[data-exercise-id="${exerciseId}"]`);
    if (exerciseCard) {
        if (progress[exerciseId].completed) {
            exerciseCard.classList.add('completed');
            // Add kitty emoji to completed exercises
            let emojiDiv = exerciseCard.querySelector('.completion-emoji');
            if (!emojiDiv) {
                emojiDiv = document.createElement('div');
                emojiDiv.className = 'completion-emoji';
                emojiDiv.textContent = '🐱';
                const header = exerciseCard.querySelector('.exercise-header');
                if (header) {
                    header.appendChild(emojiDiv);
                }
            }
        } else {
            exerciseCard.classList.remove('completed');
            // Remove kitty emoji from incomplete exercises
            const emojiDiv = exerciseCard.querySelector('.completion-emoji');
            if (emojiDiv) {
                emojiDiv.remove();
            }
        }
    }

    // Update progress indicator
    const dayMatch = exerciseId.match(/^(day\d+)/);
    if (dayMatch) {
        updateProgress(dayMatch[1]);
    }

    // Haptic feedback if available
    if (navigator.vibrate) {
        navigator.vibrate(50);
    }
}

/**
 * Update progress indicator for a workout day
 */
function updateProgress(dayId) {
    const dayData = workoutData[dayId];
    if (!dayData) return;

    const totalExercises = dayData.exercises.length;
    let completedCount = 0;

    dayData.exercises.forEach(exercise => {
        if (isExerciseCompleted(exercise.id)) {
            completedCount++;
        }
    });

    const progressElement = document.getElementById(`${dayId}-progress`);
    if (progressElement) {
        progressElement.textContent = `${completedCount} of ${totalExercises} exercises complete`;
    }

    // Check if all exercises are completed and show celebration video button
    checkAndShowCelebrationButton(dayId, completedCount, totalExercises);
}

/**
 * Check if all exercises are completed and show celebration button
 */
function checkAndShowCelebrationButton(dayId, completedCount, totalExercises) {
    const workoutContainer = document.getElementById(dayId);
    if (!workoutContainer) return;

    // Remove existing celebration button if it exists
    const existingButton = workoutContainer.querySelector('.celebration-button');
    if (existingButton) {
        existingButton.remove();
    }

    // Add celebration button if all exercises are completed
    if (completedCount === totalExercises && totalExercises > 0) {
        const celebrationButton = document.createElement('div');
        celebrationButton.className = 'celebration-button';
        celebrationButton.innerHTML = `
            <button class="btn btn-celebration" onclick="playCelebrationVideo()">
                <img src="images/cat button2.png" alt="Celebration Cat" class="celebration-image" onerror="console.error('Failed to load cat button2 image')">
            </button>
        `;

        // Insert after the cooldown section
        const cooldownSection = workoutContainer.querySelector('.cooldown');
        if (cooldownSection) {
            cooldownSection.insertAdjacentElement('afterend', celebrationButton);
            console.log('Celebration button added after cooldown section');
        } else {
            // Fallback: add to end of container
            workoutContainer.appendChild(celebrationButton);
            console.log('Celebration button added to end of container (fallback)');
        }
    }
}

/**
 * Play the celebration video
 */
function playCelebrationVideo() {
    // Haptic feedback
    if (navigator.vibrate) {
        navigator.vibrate([100, 50, 100, 50, 200]);
    }

    // Create video modal for celebration
    const videoModal = document.createElement('div');
    videoModal.className = 'modal active';
    videoModal.innerHTML = `
        <div class="modal-overlay" onclick="closeCelebrationVideo()"></div>
        <div class="modal-content celebration-modal">
            <button class="modal-close" onclick="closeCelebrationVideo()">&times;</button>
            <div class="video-container">
                <video id="celebration-video" controls autoplay>
                    <source src="images/cat ending.mp4" type="video/mp4">
                    Your browser does not support the video tag.
                </video>
            </div>
            <div class="celebration-text">
                <h3>🎉 Amazing Work, Setareh! 🎉</h3>
                <p>You've completed your entire workout! 💪✨</p>
            </div>
        </div>
    `;

    document.body.appendChild(videoModal);

    // Auto-remove modal after video ends
    const video = document.getElementById('celebration-video');
    if (video) {
        video.addEventListener('ended', () => {
            setTimeout(() => {
                closeCelebrationVideo();
            }, 2000); // Keep modal open for 2 seconds after video ends
        });
    }
}

/**
 * Close the celebration video modal
 */
function closeCelebrationVideo() {
    const modal = document.querySelector('.celebration-modal');
    if (modal) {
        modal.parentElement.remove();
    }
}

/**
 * Render exercises for a workout day
 */
function renderExercises(dayId) {
    const dayData = workoutData[dayId];
    if (!dayData) return;

    const container = document.getElementById(`${dayId}-exercises`);
    if (!container) return;

    container.innerHTML = '';

    dayData.exercises.forEach((exercise, index) => {
        const isCompleted = isExerciseCompleted(exercise.id);

        const card = document.createElement('div');
        card.className = `exercise-card ${isCompleted ? 'completed' : ''}`;
        card.dataset.exerciseId = exercise.id;

        card.innerHTML = `
            <div class="exercise-header">
                <div class="exercise-name">${exercise.name}</div>
                <div class="exercise-name-persian">(${exercise.namePersian})</div>
                ${isCompleted ? '<div class="completion-emoji">🐱</div>' : ''}
            </div>

            <div class="exercise-details">
                <div class="exercise-detail">
                    <span>Sets:</span>
                    <span>${exercise.sets}</span>
                </div>
                <div class="exercise-detail">
                    <span>Reps:</span>
                    <span>${exercise.reps}</span>
                </div>
                <div class="exercise-detail">
                    <span>Rest:</span>
                    <span>${exercise.rest} seconds</span>
                </div>
            </div>

            ${exercise.notes ? `<div class="exercise-notes">${exercise.notes}</div>` : ''}

            <div class="exercise-actions">
                <button class="btn btn-video" onclick="openVideoModal('${exercise.videoId}', '${exercise.name}')">
                    Watch Video 📹
                </button>
                <label class="checkbox-container">
                    <input
                        type="checkbox"
                        class="checkbox-input"
                        ${isCompleted ? 'checked' : ''}
                        onchange="toggleExerciseCompletion('${exercise.id}')"
                    >
                    <span class="checkbox-label">Mark Complete</span>
                </label>
            </div>
        `;

        container.appendChild(card);
    });
}

// ========== Splash Screen Functionality ==========

function initSplashScreen() {
    const splashScreen = document.getElementById('splash-screen');
    const canvas = document.getElementById('confetti-canvas');
    const ctx = canvas.getContext('2d');

    // Set canvas size
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;

    // Confetti particles
    const particles = [];
    const colors = ['#FFB6C1', '#FFC0CB', '#FF69B4', '#FF1493', '#FFD700', '#FFA500', '#FFFFFF'];

    class Particle {
        constructor(x, y) {
            this.x = x;
            this.y = y;
            this.vx = (Math.random() - 0.5) * 10;
            this.vy = (Math.random() - 0.5) * 10 - 5;
            this.gravity = 0.3;
            this.friction = 0.98;
            this.size = Math.random() * 8 + 4;
            this.color = colors[Math.floor(Math.random() * colors.length)];
            this.rotation = Math.random() * 360;
            this.rotationSpeed = (Math.random() - 0.5) * 10;
            this.alpha = 1;
        }

        update() {
            this.vy += this.gravity;
            this.vx *= this.friction;
            this.vy *= this.friction;
            this.x += this.vx;
            this.y += this.vy;
            this.rotation += this.rotationSpeed;
            this.alpha -= 0.01;
        }

        draw() {
            ctx.save();
            ctx.translate(this.x, this.y);
            ctx.rotate((this.rotation * Math.PI) / 180);
            ctx.globalAlpha = this.alpha;
            ctx.fillStyle = this.color;

            // Draw sparkle shape
            ctx.beginPath();
            for (let i = 0; i < 5; i++) {
                const angle = (Math.PI * 2 * i) / 5;
                const x = Math.cos(angle) * this.size;
                const y = Math.sin(angle) * this.size;
                if (i === 0) ctx.moveTo(x, y);
                else ctx.lineTo(x, y);
            }
            ctx.closePath();
            ctx.fill();

            ctx.restore();
        }
    }

    function createConfetti(x, y) {
        for (let i = 0; i < 50; i++) {
            particles.push(new Particle(x, y));
        }
    }

    function animateParticles() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);

        for (let i = particles.length - 1; i >= 0; i--) {
            particles[i].update();
            particles[i].draw();

            if (particles[i].alpha <= 0) {
                particles.splice(i, 1);
            }
        }

        if (particles.length > 0) {
            requestAnimationFrame(animateParticles);
        }
    }

    function startApp(e) {
        // Get click position
        const x = e.clientX || e.touches?.[0]?.clientX || canvas.width / 2;
        const y = e.clientY || e.touches?.[0]?.clientY || canvas.height / 2;

        // Create confetti at click position
        createConfetti(x, y);
        animateParticles();

        // Haptic feedback
        if (navigator.vibrate) {
            navigator.vibrate([50, 30, 50]);
        }

        // Scale dumbbell
        const dumbbell = document.querySelector('.dumbbell');
        if (dumbbell) {
            dumbbell.style.transform = 'translate(-50%, -50%) scale(1.2)';
        }

        // Navigate after brief delay for confetti effect
        setTimeout(() => {
            navigateTo('user-selection');
        }, 800);

        // Remove listeners to prevent multiple triggers
        splashScreen.removeEventListener('click', startApp);
        splashScreen.removeEventListener('touchstart', startApp);
    }

    // Simple click/tap anywhere on splash screen
    splashScreen.addEventListener('click', startApp);
    splashScreen.addEventListener('touchstart', startApp, { passive: true });

    // Resize canvas on window resize
    window.addEventListener('resize', () => {
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
    });
}

// ========== User Selection ==========

function initUserSelection() {
    // User card buttons
    document.querySelectorAll('.user-card').forEach(card => {
        card.addEventListener('click', function() {
            if (this.disabled) return;

            const userName = this.dataset.user;

            // Add clicked animation
            this.classList.add('clicked');

            // Haptic feedback
            if (navigator.vibrate) {
                navigator.vibrate([30, 20, 30]);
            }

            // Navigate to main menu after animation
            setTimeout(() => {
                navigateTo('main-menu');
                this.classList.remove('clicked');
            }, 400);
        });
    });
}

// ========== Navigation ==========

function initNavigation() {
    // Menu buttons
    document.querySelectorAll('.menu-button').forEach(button => {
        button.addEventListener('click', function() {
            const targetPage = this.dataset.page;

            // Add clicked animation
            this.classList.add('clicked');

            // Haptic feedback
            if (navigator.vibrate) {
                navigator.vibrate([30, 20, 30]);
            }

            // Navigate after animation
            setTimeout(() => {
                navigateTo(targetPage);
                this.classList.remove('clicked');
            }, 400);
        });
    });

    // Back buttons
    document.querySelectorAll('.back-button').forEach(button => {
        button.addEventListener('click', () => {
            // Haptic feedback
            if (navigator.vibrate) {
                navigator.vibrate(20);
            }
            navigateTo('main-menu');
        });
    });
}

// ========== Video Modal ==========

function openVideoModal(videoId, exerciseName) {
    // Haptic feedback
    if (navigator.vibrate) {
        navigator.vibrate([30, 20, 30]);
    }

    if (videoId && videoId !== 'PLACEHOLDER') {
        // Open YouTube Shorts in new tab (works better on mobile)
        window.open(`https://www.youtube.com/shorts/${videoId}`, '_blank');
    } else {
        alert(`Video coming soon for: ${exerciseName}`);
    }
}

function closeVideoModal() {
    // Not needed anymore, but keeping for compatibility
}

function initVideoModal() {
    // Not needed anymore, but keeping for compatibility
}

// ========== Initialization ==========

document.addEventListener('DOMContentLoaded', () => {
    console.log('🌸 Setareh\'s Workout App initialized!');

    // Initialize all components
    initSplashScreen();
    initUserSelection();
    initNavigation();
    initVideoModal();

    // Pre-render exercises for all days
    ['day1', 'day2', 'day3'].forEach(dayId => {
        renderExercises(dayId);
        updateProgress(dayId);
    });
});

// ========== Global Functions (for inline event handlers) ==========
// These are defined globally so they can be called from HTML onclick attributes
window.openVideoModal = openVideoModal;
window.closeVideoModal = closeVideoModal;
window.toggleExerciseCompletion = toggleExerciseCompletion;
window.playCelebrationVideo = playCelebrationVideo;
window.closeCelebrationVideo = closeCelebrationVideo;
