const STORAGE = {
    students: "students",
    role: "logged_in",
    username: "current_username",
    events: "events",
    participants: "event_participants"
};

const ADMIN_USERNAME = "admin";
const ADMIN_PASSWORD = "admin123";

const app = document.getElementById("app");


/* =========================
   STUDENT
========================= */

function getStudents() {
    return JSON.parse(
        localStorage.getItem(STORAGE.students) || "[]"
    );
}

function saveStudents(students) {
    localStorage.setItem(
        STORAGE.students,
        JSON.stringify(students)
    );
}


/* =========================
   EVENTS
========================= */

function getEvents() {

    const saved = localStorage.getItem(STORAGE.events);

    if (!saved) {

        const defaults = [
            {
                id: "event_1",
                name: "Class Meeting",
                date: "2026-10-10",
                time: "09:00",
                location: "Classroom",
                description: "Class meeting and discussion."
            },
            {
                id: "event_2",
                name: "Student Expo",
                date: "2026-10-15",
                time: "10:00",
                location: "School Hall",
                description: "Student project exhibition."
            }
        ];

        saveEvents(defaults);

        return defaults;
    }

    return JSON.parse(saved);
}

function saveEvents(events) {
    localStorage.setItem(
        STORAGE.events,
        JSON.stringify(events)
    );
}


/* =========================
   PARTICIPANTS
========================= */

function getParticipants() {
    return JSON.parse(
        localStorage.getItem(
            STORAGE.participants
        ) || "{}"
    );
}

function saveParticipants(data) {
    localStorage.setItem(
        STORAGE.participants,
        JSON.stringify(data)
    );
}


/* =========================
   LOGIN
========================= */

function currentUsername() {
    return localStorage.getItem(
        STORAGE.username
    );
}

function currentStudent() {

    const username = currentUsername();

    return getStudents().find(
        student => student.username === username
    ) || null;
}

function setLogin(role, username) {

    localStorage.setItem(
        STORAGE.role,
        role
    );

    localStorage.setItem(
        STORAGE.username,
        username
    );
}

function logout() {

    localStorage.removeItem(STORAGE.role);
    localStorage.removeItem(STORAGE.username);

    renderLanding();
}


/* =========================
   BRAND
========================= */

function brand() {

    return `
        <div class="brand">

            <div class="brand-icon">
                SE
            </div>

            <div>
                <h1>School Event</h1>
                <p>Management System</p>
            </div>

        </div>
    `;
}


/* =========================
   TOPBAR
========================= */

function topbar() {

    return `
        <div class="topbar">

            <button
                class="back-btn"
                onclick="renderLanding()"
            >
                ←
            </button>

        </div>
    `;
}


/* =========================
   EYE ICON
========================= */

function eyeIcon() {

    return `
        <svg
            class="eye-icon"
            viewBox="0 0 24 24"
            aria-hidden="true"
        >
            <path
                d="M2 12s3.5-6 10-6 10 6 10 6-3.5 6-10 6S2 12 2 12Z"
            ></path>

            <circle
                cx="12"
                cy="12"
                r="3"
            ></circle>
        </svg>
    `;
}


/* =========================
   LANDING
========================= */

function renderLanding() {

    app.innerHTML = `

        <div class="screen center-screen">

            <div class="container landing">

                ${brand()}

                <h1>
                    School Event
                </h1>

                <h2>
                    Management System
                </h2>

                <p class="landing-description">
                    Manage school events, registrations,
                    and participants in one simple application.
                </p>

                <button
                    class="btn full"
                    onclick="renderLogin()"
                >
                    Get Started
                </button>

            </div>

        </div>
    `;
}


/* =========================
   LOGIN
========================= */

function renderLogin() {

    app.innerHTML = `

        ${topbar()}

        <div class="screen center-screen">

            <div class="container">

                ${brand()}

                <h1 class="page-title">
                    Welcome Back
                </h1>

                <p class="page-subtitle">
                    Login to continue to School Event.
                </p>


                <form onsubmit="handleLogin(event)">

                    <div class="form-group">

                        <label>
                            Username
                        </label>

                        <input
                            id="loginUsername"
                            type="text"
                            autocomplete="username"
                            placeholder="Enter username"
                            required
                        >

                    </div>


                    <div class="form-group">

                        <label>
                            Password
                        </label>

                        <div class="input-wrap">

                            <input
                                id="loginPassword"
                                class="password-input"
                                type="password"
                                autocomplete="current-password"
                                placeholder="Enter password"
                                required
                            >

                            <button
                                type="button"
                                class="password-toggle"
                                onclick="togglePassword(
                                    'loginPassword',
                                    this
                                )"
                                aria-label="Show password"
                            >
                                ${eyeIcon()}
                            </button>

                        </div>

                    </div>


                    <button
                        class="btn full"
                        type="submit"
                    >
                        Login
                    </button>

                </form>


                <div class="center-text">

                    <button
                        class="text-btn"
                        onclick="renderRegister()"
                    >
                        New here? Create an account
                    </button>

                </div>

            </div>

        </div>
    `;
}


/* =========================
   REGISTER
========================= */

function renderRegister() {

    app.innerHTML = `

        ${topbar()}

        <div class="screen center-screen">

            <div class="container">

                ${brand()}

                <h1 class="page-title">
                    Create Account
                </h1>

                <p class="page-subtitle">
                    Register as a student to join school events.
                </p>


                <form onsubmit="handleRegister(event)">

                    <div class="form-group">

                        <label>
                            Full Name
                        </label>

                        <input
                            id="regName"
                            type="text"
                            placeholder="Enter your full name"
                            required
                        >

                    </div>


                    <div class="form-group">

                        <label>
                            Class
                        </label>

                        <input
                            id="regClass"
                            type="text"
                            placeholder="e.g. X-PPLG"
                            required
                        >

                    </div>


                    <div class="form-group">

                        <label>
                            Username
                        </label>

                        <input
                            id="regUsername"
                            type="text"
                            autocomplete="username"
                            placeholder="Choose username"
                            required
                        >

                    </div>


                    <div class="form-group">

                        <label>
                            Password
                        </label>

                        <div class="input-wrap">

                            <input
                                id="regPassword"
                                class="password-input"
                                type="password"
                                placeholder="Create password"
                                required
                            >

                            <button
                                type="button"
                                class="password-toggle"
                                onclick="togglePassword(
                                    'regPassword',
                                    this
                                )"
                                aria-label="Show password"
                            >
                                ${eyeIcon()}
                            </button>

                        </div>

                    </div>


                    <div class="form-group">

                        <label>
                            Confirm Password
                        </label>

                        <div class="input-wrap">

                            <input
                                id="regConfirm"
                                class="password-input"
                                type="password"
                                placeholder="Repeat password"
                                required
                            >

                            <button
                                type="button"
                                class="password-toggle"
                                onclick="togglePassword(
                                    'regConfirm',
                                    this
                                )"
                                aria-label="Show password"
                            >
                                ${eyeIcon()}
                            </button>

                        </div>

                    </div>


                    <button
                        class="btn full"
                        type="submit"
                    >
                        Create Account
                    </button>

                </form>


                <div class="center-text">

                    <button
                        class="text-btn"
                        onclick="renderLogin()"
                    >
                        Already have an account? Login
                    </button>

                </div>

            </div>

        </div>
    `;
}


/* =========================
   SHOW / HIDE PASSWORD
========================= */

function togglePassword(id, button) {

    const input =
        document.getElementById(id);

    if (input.type === "password") {

        input.type = "text";

        button.classList.add("show");

        button.setAttribute(
            "aria-label",
            "Hide password"
        );

    } else {

        input.type = "password";

        button.classList.remove("show");

        button.setAttribute(
            "aria-label",
            "Show password"
        );
    }
}


/* =========================
   HANDLE LOGIN
========================= */

function handleLogin(event) {

    event.preventDefault();

    const username =
        document
            .getElementById("loginUsername")
            .value
            .trim();

    const password =
        document
            .getElementById("loginPassword")
            .value;


    /* ADMIN */

    if (
        username === ADMIN_USERNAME &&
        password === ADMIN_PASSWORD
    ) {

        setLogin(
            "admin",
            username
        );

        renderAdmin();

        return;
    }


    /* STUDENT */

    const student =
        getStudents().find(
            student =>
                student.username === username &&
                student.password === password
        );


    if (!student) {

        alert(
            "Username atau password salah."
        );

        return;
    }


    setLogin(
        "student",
        username
    );

    renderStudent();
}


/* =========================
   HANDLE REGISTER
========================= */

function handleRegister(event) {

    event.preventDefault();


    const name =
        document
            .getElementById("regName")
            .value
            .trim();

    const studentClass =
        document
            .getElementById("regClass")
            .value
            .trim();

    const username =
        document
            .getElementById("regUsername")
            .value
            .trim();

    const password =
        document
            .getElementById("regPassword")
            .value;

    const confirm =
        document
            .getElementById("regConfirm")
            .value;


    if (password !== confirm) {

        alert(
            "Konfirmasi password tidak sama."
        );

        return;
    }


    const students =
        getStudents();


    if (
        students.some(
            student =>
                student.username === username
        )
    ) {

        alert(
            "Username sudah digunakan."
        );

        return;
    }


    students.push({

        name: name,

        class: studentClass,

        username: username,

        password: password

    });


    saveStudents(
        students
    );


    alert(
        "Registrasi berhasil."
    );


    renderLogin();
}


/* =========================
   EVENT CARD
========================= */

function eventCard(
    event,
    admin = false
) {

    return `

        <div class="event-card">

            <h3 class="event-title">
                ${escapeHtml(event.name)}
            </h3>


            <div class="info-row">
                <span>📅</span>
                <span>
                    ${escapeHtml(event.date)}
                </span>
            </div>


            <div class="info-row">
                <span>⏰</span>
                <span>
                    ${escapeHtml(event.time)}
                </span>
            </div>


            <div class="info-row">
                <span>📍</span>
                <span>
                    ${escapeHtml(event.location)}
                </span>
            </div>


            <p class="event-description">
                ${escapeHtml(event.description)}
            </p>


            <div class="card-actions">

                ${
                    admin

                    ? `

                        <button
                            class="btn outline"
                            onclick="
                                showParticipants(
                                    '${event.id}'
                                )
                            "
                        >
                            Participants
                        </button>


                        <button
                            class="btn outline"
                            onclick="
                                showEventForm(
                                    '${event.id}'
                                )
                            "
                        >
                            Edit
                        </button>


                        <button
                            class="btn danger"
                            onclick="
                                deleteEvent(
                                    '${event.id}'
                                )
                            "
                        >
                            Delete
                        </button>

                    `

                    : `

                        <button
                            class="btn full"
                            onclick="
                                registerForEvent(
                                    '${event.id}'
                                )
                            "
                        >
                            ${
                                isRegistered(event.id)
                                    ? "✓ Registered"
                                    : "Register"
                            }
                        </button>

                    `
                }

            </div>

        </div>
    `;
}


/* =========================
   STUDENT DASHBOARD
========================= */

function renderStudent() {

    const student =
        currentStudent();

    const events =
        getEvents();


    app.innerHTML = `

        <div class="screen">

            <div class="wide-container">

                <div class="student-header">

                    <div style="
                        display:flex;
                        justify-content:space-between;
                        align-items:flex-start;
                        gap:15px;
                    ">

                        <div>

                            <h1>
                                Hello,
                                ${escapeHtml(
                                    student?.name ||
                                    "Student"
                                )}
                            </h1>

                            <div class="muted">
                                Class:
                                ${escapeHtml(
                                    student?.class ||
                                    "-"
                                )}
                            </div>

                        </div>


                        <button
                            class="btn outline logout"
                            onclick="logout()"
                        >
                            Logout
                        </button>

                    </div>

                </div>


                <h2 class="section-title">
                    Available Events
                </h2>


                ${
                    events.length

                    ? events
                        .map(
                            event =>
                                eventCard(
                                    event,
                                    false
                                )
                        )
                        .join("")

                    : `
                        <div class="empty">
                            No events available.
                        </div>
                    `
                }

            </div>

        </div>
    `;
}


/* =========================
   CHECK REGISTER
========================= */

function isRegistered(eventId) {

    const username =
        currentUsername();

    const participants =
        getParticipants();


    return (
        participants[eventId] || []
    ).some(
        participant =>
            participant.username === username
    );
}


/* =========================
   REGISTER EVENT
========================= */

function registerForEvent(eventId) {

    const student =
        currentStudent();


    if (!student) {
        return;
    }


    const participants =
        getParticipants();


    participants[eventId] =
        participants[eventId] || [];


    if (
        participants[eventId].some(
            participant =>
                participant.username ===
                student.username
        )
    ) {

        alert(
            "Kamu sudah terdaftar di event ini."
        );

        return;
    }


    participants[eventId].push({

        name: student.name,

        class: student.class,

        username: student.username

    });


    saveParticipants(
        participants
    );


    renderStudent();
}


/* =========================
   ADMIN DASHBOARD
========================= */

function renderAdmin() {

    const events =
        getEvents();


    app.innerHTML = `

        <div class="screen">

            <div class="wide-container">

                <div class="dashboard-head">

                    <div>

                        <h1>
                            Dashboard
                        </h1>

                        <div class="event-count">
                            Total Events:
                            ${events.length}
                        </div>

                    </div>


                    <div style="
                        display:flex;
                        gap:8px;
                    ">

                        <button
                            class="btn"
                            onclick="showEventForm()"
                        >
                            + Add Event
                        </button>


                        <button
                            class="btn outline logout"
                            onclick="logout()"
                        >
                            Logout
                        </button>

                    </div>

                </div>


                ${
                    events.length

                    ? events
                        .map(
                            event =>
                                eventCard(
                                    event,
                                    true
                                )
                        )
                        .join("")

                    : `
                        <div class="empty">
                            No events available.
                        </div>
                    `
                }

            </div>

        </div>
    `;
}


/* =========================
   ADD / EDIT EVENT
========================= */

function showEventForm(id = null) {

    const event =
        id
            ? getEvents().find(
                item => item.id === id
            )
            : null;


    app.insertAdjacentHTML(
        "beforeend",

        `

        <div
            class="modal-backdrop"
            id="eventModal"
        >

            <div class="modal">

                <h2>
                    ${
                        event
                            ? "Edit Event"
                            : "Add Event"
                    }
                </h2>


                <form
                    onsubmit="
                        saveEvent(
                            event,
                            '${id || ""}'
                        )
                    "
                >

                    <div class="form-group">

                        <label>
                            Event Name
                        </label>

                        <input
                            id="eventName"
                            value="${escapeAttr(
                                event?.name || ""
                            )}"
                            required
                        >

                    </div>


                    <div class="form-group">

                        <label>
                            Date
                        </label>

                        <input
                            id="eventDate"
                            type="date"
                            value="${escapeAttr(
                                event?.date || ""
                            )}"
                            required
                        >

                    </div>


                    <div class="form-group">

                        <label>
                            Time
                        </label>

                        <input
                            id="eventTime"
                            type="time"
                            value="${escapeAttr(
                                event?.time || ""
                            )}"
                            required
                        >

                    </div>


                    <div class="form-group">

                        <label>
                            Location
                        </label>

                        <input
                            id="eventLocation"
                            value="${escapeAttr(
                                event?.location || ""
                            )}"
                            required
                        >

                    </div>


                    <div class="form-group">

                        <label>
                            Description
                        </label>

                        <textarea
                            id="eventDescription"
                            required
                        >${escapeHtml(
                            event?.description || ""
                        )}</textarea>

                    </div>


                    <div class="modal-actions">

                        <button
                            type="button"
                            class="btn outline"
                            onclick="closeModal()"
                        >
                            Cancel
                        </button>


                        <button
                            type="submit"
                            class="btn"
                        >
                            ${
                                event
                                    ? "Save"
                                    : "Add"
                            }
                        </button>

                    </div>

                </form>

            </div>

        </div>

        `
    );
}


/* =========================
   SAVE EVENT
========================= */

function saveEvent(
    eventForm,
    id
) {

    eventForm.preventDefault();


    const events =
        getEvents();


    const newEvent = {

        id:
            id ||
            "event_" +
            Date.now(),

        name:
            document
                .getElementById("eventName")
                .value
                .trim(),

        date:
            document
                .getElementById("eventDate")
                .value
                .trim(),

        time:
            document
                .getElementById("eventTime")
                .value
                .trim(),

        location:
            document
                .getElementById("eventLocation")
                .value
                .trim(),

        description:
            document
                .getElementById("eventDescription")
                .value
                .trim()
    };


    if (id) {

        const index =
            events.findIndex(
                event =>
                    event.id === id
            );


        if (index !== -1) {
            events[index] = newEvent;
        }

    } else {

        events.push(newEvent);
    }


    saveEvents(events);

    closeModal();

    renderAdmin();
}


/* =========================
   CLOSE MODAL
========================= */

function closeModal() {

    document
        .querySelector(".modal-backdrop")
        ?.remove();
}


/* =========================
   DELETE EVENT
========================= */

function deleteEvent(id) {

    const event =
        getEvents().find(
            item => item.id === id
        );


    if (
        !confirm(
            `Delete "${event?.name}" and its participants?`
        )
    ) {
        return;
    }


    saveEvents(
        getEvents().filter(
            event =>
                event.id !== id
        )
    );


    const participants =
        getParticipants();


    delete participants[id];


    saveParticipants(
        participants
    );


    renderAdmin();
}


/* =========================
   PARTICIPANTS
========================= */

function showParticipants(eventId) {

    const event =
        getEvents().find(
            item =>
                item.id === eventId
        );


    const participants =
        getParticipants()[eventId] || [];


    const list =
        participants.length

        ? participants
            .map(
                (participant, index) => `

                    <div class="participant">

                        <div class="avatar">
                            ${index + 1}
                        </div>

                        <div class="participant-info">

                            <strong>
                                ${escapeHtml(
                                    participant.name
                                )}
                            </strong>

                            <span>
                                Class:
                                ${escapeHtml(
                                    participant.class
                                )}
                            </span>

                            <span>
                                Username:
                                ${escapeHtml(
                                    participant.username
                                )}
                            </span>

                        </div>

                    </div>
                `
            )
            .join("")

        : `
            <div class="empty">
                No students have registered yet.
            </div>
        `;


    app.insertAdjacentHTML(

        "beforeend",

        `

        <div
            class="modal-backdrop"
        >

            <div class="modal">

                <h2>
                    Participants
                </h2>

                <p class="muted">
                    ${escapeHtml(
                        event?.name || ""
                    )}
                </p>

                <div style="
                    margin-top:18px;
                ">
                    ${list}
                </div>

                <div class="modal-actions">

                    <button
                        class="btn outline"
                        onclick="closeModal()"
                    >
                        Close
                    </button>

                </div>

            </div>

        </div>

        `
    );
}


/* =========================
   ESCAPE HTML
========================= */

function escapeHtml(value) {

    return String(value ?? "")

        .replaceAll(
            "&",
            "&amp;"
        )

        .replaceAll(
            "<",
            "&lt;"
        )

        .replaceAll(
            ">",
            "&gt;"
        )

        .replaceAll(
            '"',
            "&quot;"
        )

        .replaceAll(
            "'",
            "&#039;"
        );
}


function escapeAttr(value) {

    return escapeHtml(value);
}


/* =========================
   START APP
========================= */

function startApp() {

    const role =
        localStorage.getItem(
            STORAGE.role
        );


    if (role === "admin") {

        renderAdmin();

    } else if (role === "student") {

        renderStudent();

    } else {

        renderLanding();
    }
}


startApp();