function sleep(time) {
    return new Promise((resolve) => setTimeout(resolve, time));
}

const load_tsparticles = async () => {
    await loadLinksPreset(tsParticles);

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
};


const wrapper = async () => {
    while (true) {
        try {
            await load_tsparticles();
            break;
        }
        catch (e) {
            console.log(e);

            if (e instanceof TypeError) {
                console.log("TypeError, inserting again!");

                var body = document.getElementsByTagName("body")[0];

                //get src of scripts
                src = [];
                for (var i = 0; i < body.getElementsByTagName("script").length; i++) {
                    // if tsparticles in src
                    if (body.getElementsByTagName("script")[i].src.includes("tsparticles")) {
                        body.removeChild(body.getElementsByTagName("script")[i]);;
                    }
                }

                var body = document.querySelector("body");

                var scripts = ["https://cdn.jsdelivr.net/npm/tsparticles-engine@2/tsparticles.engine.min.js",
                    "https://cdn.jsdelivr.net/npm/tsparticles-basic@2/tsparticles.basic.min.js",
                    "https://cdn.jsdelivr.net/npm/tsparticles-interaction-particles-links@2/tsparticles.interaction.particles.links.min.js",
                    "https://cdn.jsdelivr.net/npm/tsparticles-move-base@2/tsparticles.move.base.min.js",
                    "https://cdn.jsdelivr.net/npm/tsparticles-shape-circle@2/tsparticles.shape.circle.min.js",
                    "https://cdn.jsdelivr.net/npm/tsparticles-updater-color@2/tsparticles.updater.color.min.js",
                    "https://cdn.jsdelivr.net/npm/tsparticles-updater-opacity@2/tsparticles.updater.opacity.min.js",
                    "https://cdn.jsdelivr.net/npm/tsparticles-updater-out-modes@2/tsparticles.updater.out-modes.min.js",
                    "https://cdn.jsdelivr.net/npm/tsparticles-updater-size@2/tsparticles.updater.size.min.js",
                    "https://cdn.jsdelivr.net/npm/tsparticles-preset-triangles@2/tsparticles.preset.triangles.min.js",
                    "https://cdn.jsdelivr.net/npm/tsparticles-preset-links@2/tsparticles.preset.links.min.js"];

                scripts.forEach((script, i) => {
                    var script = document.createElement("script");
                    script.src = scripts[i];
                    body.appendChild(script);
                });
            }



            await sleep(10);

        }
    }
};

wrapper();


