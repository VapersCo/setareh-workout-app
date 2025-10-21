// ==========================================
// Setareh's Workout App - Workout Data
// Complete 3-Day Functional Training Program
// ==========================================

const workoutData = {
    day1: {
        name: "Lower Body & Core",
        emoji: "🌸",
        warmup: [
            {
                name: "Marching in place",
                namePersian: "مارش در محل",
                duration: "2 minutes",
                videoId: "5l-A5_-BPUg"
            },
            {
                name: "Hip circles",
                namePersian: "دایره ران",
                reps: "10 each direction",
                videoId: "OqR7Tl6SPLQ"
            },
            {
                name: "Leg swings",
                namePersian: "نوسان پا",
                reps: "10 each leg",
                videoId: "DTXpjDJDoeI"
            }
        ],
        exercises: [
            {
                id: "d1-e1",
                name: "Bodyweight Squats",
                namePersian: "حرکت اسکوات",
                sets: 3,
                reps: 12,
                rest: 60,
                videoId: "L7FV0Z7k4No",
                notes: "Keep chest up, weight in heels"
            },
            {
                id: "d1-e2",
                name: "Reverse Lunges",
                namePersian: "لانژ معکوس",
                sets: 3,
                reps: "10 each leg",
                rest: 60,
                videoId: "ljZA17b52FE",
                notes: "Step back and lower until front knee is at 90 degrees"
            },
            {
                id: "d1-e3",
                name: "Glute Bridges",
                namePersian: "بریج باسن",
                sets: 3,
                reps: 15,
                rest: 45,
                videoId: "X_IGw8U_e38",
                notes: "Squeeze glutes at the top, hold for 1 second"
            },
            {
                id: "d1-e4",
                name: "Plank Hold",
                namePersian: "پلانک",
                sets: 3,
                reps: "20-30 seconds",
                rest: 45,
                videoId: "oPgZR4jlZi4",
                notes: "Keep body in straight line, don't let hips sag"
            },
            {
                id: "d1-e5",
                name: "Dead Bug",
                namePersian: "دد باگ",
                sets: 3,
                reps: "10 each side",
                rest: 45,
                videoId: "_wXaGBkegdY",
                notes: "Lower back stays pressed to floor throughout"
            }
        ],
        cooldown: {
            name: "Full body stretching",
            duration: "5 minutes"
        }
    },

    day2: {
        name: "Upper Body & Core",
        emoji: "✨",
        warmup: [
            {
                name: "Arm circles",
                namePersian: "دایره بازو",
                reps: "10 each direction",
                videoId: "cgKSxonUrZI"
            },
            {
                name: "Shoulder rolls",
                namePersian: "چرخش شانه",
                reps: "10 forward, 10 back",
                videoId: "A7kgx8gGmPA"
            },
            {
                name: "Cat-cow stretch",
                namePersian: "کشش گربه-گاو",
                reps: "10 reps",
                videoId: "oMDrs7dPtxI"
            }
        ],
        exercises: [
            {
                id: "d2-e1",
                name: "Push-ups",
                namePersian: "شنا",
                sets: 3,
                reps: "8-12",
                rest: 60,
                videoId: "wD1M-f69Yy8",
                notes: "Knee push-ups OK for beginners - keep elbows at 45 degrees"
            },
            {
                id: "d2-e2",
                name: "Dumbbell Rows",
                namePersian: "پارویی با دمبل",
                sets: 3,
                reps: "12 each arm",
                rest: 60,
                videoId: "WkFX6_GxAs8",
                notes: "Pull elbow back and up, squeeze shoulder blade"
            },
            {
                id: "d2-e3",
                name: "Dumbbell Shoulder Press",
                namePersian: "پرس سرشانه",
                sets: 3,
                reps: 10,
                rest: 60,
                videoId: "k6tzKisR3NY",
                notes: "Press straight up, don't arch back excessively"
            },
            {
                id: "d2-e4",
                name: "Tricep Dips",
                namePersian: "دیپ سه سر",
                sets: 3,
                reps: 10,
                rest: 45,
                videoId: "0M2W8MgC8Qk",
                notes: "Use a chair or bench - keep shoulders down"
            },
            {
                id: "d2-e5",
                name: "Russian Twists",
                namePersian: "چرخش روسی",
                sets: 3,
                reps: "20 total",
                rest: 45,
                videoId: "KUsvxlmpPoI",
                notes: "Twist from the core, tap floor on each side"
            }
        ],
        cooldown: {
            name: "Upper body stretching",
            duration: "5 minutes"
        }
    },

    day3: {
        name: "Full Body",
        emoji: "🎀",
        warmup: [
            {
                name: "Jumping jacks",
                namePersian: "جامپینگ جک",
                duration: "30 seconds",
                videoId: "g03AajXXbHE"
            },
            {
                name: "Bodyweight squats",
                namePersian: "اسکوات",
                reps: "10 reps",
                videoId: "iZTxa8NJH2g"
            },
            {
                name: "Arm swings",
                namePersian: "نوسان بازو",
                reps: "10 each direction",
                videoId: "Wl2F3qhTpP0"
            }
        ],
        exercises: [
            {
                id: "d3-e1",
                name: "Goblet Squats",
                namePersian: "اسکوات گابلت",
                sets: 3,
                reps: 12,
                rest: 60,
                videoId: "7E-ugKcWeu4",
                notes: "Hold dumbbell at chest, squat deep"
            },
            {
                id: "d3-e2",
                name: "Step-ups",
                namePersian: "بالا رفتن از پله",
                sets: 3,
                reps: "10 each leg",
                rest: 60,
                videoId: "OlsIQNNYszE",
                notes: "Use stairs or sturdy platform, drive through heel"
            },
            {
                id: "d3-e3",
                name: "Dumbbell Thrusters",
                namePersian: "تراسترز",
                sets: 3,
                reps: 10,
                rest: 60,
                videoId: "k8QsgOFLp_g",
                notes: "Squat + overhead press in one fluid motion"
            },
            {
                id: "d3-e4",
                name: "Mountain Climbers",
                namePersian: "کوهنوردی",
                sets: 3,
                reps: "20 total",
                rest: 45,
                videoId: "K3Xt4QH4b-U",
                notes: "Keep hips level, drive knees to chest quickly"
            },
            {
                id: "d3-e5",
                name: "Bird Dogs",
                namePersian: "برد داگ",
                sets: 3,
                reps: "10 each side",
                rest: 45,
                videoId: "wh2spJeDDQs",
                notes: "Extend opposite arm and leg, hold for 2 seconds"
            }
        ],
        cooldown: {
            name: "Full body cool down",
            duration: "5 minutes"
        }
    }
};

// Export for use in script.js
// (This works in browsers without module system)
if (typeof module !== 'undefined' && module.exports) {
    module.exports = workoutData;
}
