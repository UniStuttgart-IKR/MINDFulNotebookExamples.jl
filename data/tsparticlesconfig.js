// @path-json can be an object or an array, the first will be loaded directly, and the object from the array will be randomly selected
/* tsParticles.load(@params); */


// (async () => {
//     await loadTrianglesPreset(tsParticles); // this is required only if you are not using the bundle script
//
//     await tsParticles.load("tsparticles", {
//         particles: {
//             shape: {
//                 type: "square", // starting from v2, this require the square shape script
//             },
//
//         },
//
//
//         preset: "triangles",
//     });
// })();


(async () => {
    await loadLinksPreset(tsParticles); // this is required only if you are not using the bundle script

    await tsParticles.load("tsparticles", {
        fullScreen: {
            enable: true,
            zIndex: -10
        },
        particles: {
            number: {
                density: {
                    enable: true,
                    width: 1920,
                    height: 1080
                },
                "limit": 0,
                "value": 100
            },
            size: {
                value: 4,
            },
            opacity: {
                random: {
                    enable: true,
                    minimumValue: 0.3
                },
                value: {
                    min: 0.3,
                    max: 0.8
                },
                animation: {
                    count: 0,
                    enable: true,
                    speed: 0.5,
                    decay: 0,
                    delay: 0,
                    sync: false,
                    mode: "auto",
                    startValue: "random",
                    destroy: "none",
                    minimumValue: 0.3
                }
            },
            color: {
                value: "#f399ff",
            },
            links: {
                color: "#f399ff",
                distance: 200,
                enable: true,
                opacity: 0.8,
                width: 2,

            },

            move: {
                angle: {
                    offset: 0,
                    value: 90
                },
                attract: {
                    distance: 200,
                    enable: true,
                    rotate: {
                        x: 3000,
                        y: 3000
                    }
                },
                center: {
                    x: 50,
                    y: 50,
                    mode: "percent",
                    radius: 0
                },
                decay: 0,
                distance: {},
                direction: "none",
                drift: 0,
                enable: true,
                gravity: {
                    acceleration: 9.81,
                    enable: false,
                    inverse: false,
                    maxSpeed: 50
                },
                path: {
                    clamp: true,
                    delay: {
                        random: {
                            enable: false,
                            minimumValue: 0
                        },
                        value: 0
                    },
                    enable: false,
                    options: {}
                },
                outModes: {
                    default: "out",
                    bottom: "out",
                    left: "out",
                    right: "out",
                    top: "out"
                },
                random: false,
                size: false,
                speed: 2,
                spin: {
                    acceleration: 0,
                    enable: false
                },
                straight: false,
                trail: {
                    enable: false,
                    length: 10,
                    fill: {}
                },
                vibrate: false,
                warp: false
            }

        },

        interactivity: {
            detectsOn: "window",
            events: {
                onHover: {
                    enable: true,
                    mode: "grab",
                    parallax: {
                        enable: true,
                        force: 2,
                        smooth: 10
                    }
                }
            },
            modes: {
                grab: {
                    distance: 150,
                    links: {
                        blink: false,
                        consent: false,
                        opacity: 1
                    }
                },
            }
        },
        preset: "links",
    });
})();

// (async () => {
//     await tsParticles.load({
//         id: "tsparticles",
//         url: "static/index/particles.json",
//     });
// })();


//the second one
// Important! If the index is not in range 0...<array.length, the index will be ignored.

// after initialization this can be used.

/* tsParticles.setOnClickHandler(@callback); */

/* this will be fired from all particles loaded */

// tsParticles.setOnClickHandler((event, particles) => {
//     /* custom on click handler */
// });

// now you can control the animations too, it's possible to pause and resume the animations
// these methods don't change the config so you're safe with all your configurations
// domItem(0) returns the first tsParticles instance loaded in the dom
const particles = tsParticles.domItem(0);

// play will start the animations, if the move is not enabled it won't enable it, it just updates the frame
particles.play();

// pause will stop the animations
particles.pause();