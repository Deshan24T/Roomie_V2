<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<nav class="roomie-nav" id="mainNav">
    <div class="nav-container">
        <a class="nav-brand" href="/">
            <img class="theme-logo" src="/images/logo-dark.png" alt="Roomie Logo" style="height: 60px; width: auto; object-fit: contain;">
        </a>
        <button class="nav-toggle" id="navToggle" aria-label="Toggle menu">
            <span></span><span></span><span></span>
        </button>
        <div class="nav-menu" id="navMenu">
            <ul class="nav-links">
                <c:if test="${empty sessionScope.loggedAdmin}">
                    <li><a href="/room/list" class="nav-link-item">Rooms</a></li>
                    <li><a href="/review/all" class="nav-link-item">Reviews</a></li>
                </c:if>
                <c:choose>
                    <c:when test="${not empty sessionScope.loggedCustomer}">
                        <li><a href="/reservation/my" class="nav-link-item">My Bookings</a></li>
                        <li><a href="/customer/profile" class="nav-link-item nav-user">
                            <span class="user-avatar">${sessionScope.loggedCustomer.firstName.charAt(0)}</span>
                            ${sessionScope.loggedCustomer.firstName}
                        </a></li>
                        <li><a href="/customer/logout" class="nav-btn nav-btn-outline">Logout</a></li>
                    </c:when>
                    <c:when test="${not empty sessionScope.loggedAdmin}">
                        <li><a href="/admin/dashboard" class="nav-link-item">Dashboard</a></li>
                        <li><a href="/room/manage" class="nav-link-item">Manage Rooms</a></li>
                        <li><a href="/admin/reservations" class="nav-link-item">Reservations</a></li>
                        <li><a href="/admin/customers" class="nav-link-item">Customers</a></li>
                        <li><a href="/admin/logout" class="nav-btn nav-btn-outline">Logout</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="/customer/login" class="nav-link-item">Login</a></li>
                        <li><a href="/customer/register" class="nav-btn nav-btn-primary">Sign Up Free</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
            <button class="theme-toggle" id="themeToggle" aria-label="Toggle dark mode" title="Toggle dark/light mode">
                <span class="theme-icon">🌙</span>
            </button>
        </div>
    </div>
</nav>

<style>
:root {
    --nav-text: #e2e8f0;
    --nav-hover: #c9a84c;
    --nav-brand: #c9a84c;
    --nav-btn-bg: #c9a84c;
    --nav-btn-text: #0f172a;
    --nav-height: 70px;
}
[data-theme="light"] {
    --nav-text: #1e293b;
    --nav-hover: #b8860b;
    --nav-brand: #1e3a5f;
    --nav-btn-bg: #1e3a5f;
    --nav-btn-text: #fff;
}
.roomie-nav {
    position: fixed; top: 0; left: 0; right: 0; z-index: 1000;
    background: transparent;
    border-bottom: 1px solid transparent;
    height: var(--nav-height);
    transition: background 0.4s ease, border-color 0.4s ease,
                box-shadow 0.4s ease, backdrop-filter 0.4s ease;
}
.roomie-nav.scrolled {
    background: rgba(8, 14, 26, 0.75);
    backdrop-filter: blur(16px);
    -webkit-backdrop-filter: blur(16px);
    border-bottom: 1px solid rgba(201, 168, 76, 0.15);
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.45);
}
[data-theme="light"] .roomie-nav.scrolled {
    background: rgba(240, 244, 248, 0.82);
    backdrop-filter: blur(16px);
    -webkit-backdrop-filter: blur(16px);
    border-bottom: 1px solid rgba(30, 58, 95, 0.12);
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
}
.nav-container {
    max-width: 1400px; margin: 0 auto; padding: 0 2rem;
    display: flex; align-items: center; height: 100%; gap: 2rem;
}
.nav-brand {
    font-family: 'Outfit', sans-serif;
    font-size: 1.6rem; font-weight: 700; color: var(--nav-brand);
    text-decoration: none; display: flex; align-items: center; gap: 0.5rem;
    letter-spacing: 0.5px; transition: opacity 0.2s;
}
.nav-brand:hover { opacity: 0.85; }
.brand-icon { font-size: 1.4rem; }
.nav-menu { display: flex; align-items: center; gap: 0.5rem; margin-left: auto; }
.nav-links { list-style: none; display: flex; align-items: center; gap: 0.3rem; margin: 0; padding: 0; }
.nav-link-item {
    color: var(--nav-text); text-decoration: none; padding: 0.5rem 0.9rem;
    border-radius: 8px; font-size: 0.92rem; font-weight: 500; letter-spacing: 0.2px;
    transition: all 0.2s ease; white-space: nowrap;
}
.nav-link-item:hover { color: var(--nav-hover); background: rgba(201,168,76,0.1); }
.nav-user { display: flex; align-items: center; gap: 0.5rem; }
.user-avatar {
    width: 28px; height: 28px; border-radius: 50%;
    background: var(--nav-btn-bg); color: var(--nav-btn-text);
    display: flex; align-items: center; justify-content: center;
    font-size: 0.75rem; font-weight: 700;
}
.nav-btn {
    padding: 0.45rem 1.2rem; border-radius: 25px; font-size: 0.88rem;
    font-weight: 600; text-decoration: none; transition: all 0.25s ease; white-space: nowrap;
}
.nav-btn-primary { background: var(--nav-btn-bg); color: var(--nav-btn-text); }
.nav-btn-primary:hover { transform: translateY(-1px); box-shadow: 0 4px 15px rgba(201,168,76,0.4); filter: brightness(1.1); }
.nav-btn-outline {
    border: 1.5px solid var(--nav-hover); color: var(--nav-hover);
    background: transparent;
}
.nav-btn-outline:hover { background: var(--nav-hover); color: var(--nav-btn-text); }
.theme-toggle {
    background: none; border: 1.5px solid rgba(201,168,76,0.4); border-radius: 50%;
    width: 36px; height: 36px; cursor: pointer; font-size: 1rem; transition: all 0.3s;
    margin-left: 0.5rem; display: flex; align-items: center; justify-content: center;
}
.theme-toggle:hover { border-color: var(--nav-hover); transform: rotate(20deg); }
.nav-toggle {
    display: none; flex-direction: column; gap: 5px; background: none; border: none;
    cursor: pointer; padding: 4px; margin-left: auto;
}
.nav-toggle span {
    display: block; width: 24px; height: 2px; background: var(--nav-text);
    border-radius: 2px; transition: all 0.3s;
}
@media (max-width: 900px) {
    .nav-toggle { display: flex; }
    .nav-menu {
        display: none; position: absolute; top: var(--nav-height); left: 0; right: 0;
        background: var(--nav-bg); flex-direction: column; padding: 1.5rem 2rem;
        border-top: 1px solid rgba(201,168,76,0.2); gap: 0.5rem;
    }
    .nav-menu.open { display: flex; }
    .nav-links { flex-direction: column; width: 100%; gap: 0.3rem; }
    .nav-link-item, .nav-btn { display: block; text-align: center; width: 100%; padding: 0.7rem 1rem; }
}
</style>
<script>
(function(){
    // Theme
    const saved = localStorage.getItem('roomie-theme') || 'dark';
    document.documentElement.setAttribute('data-theme', saved);
    window.addEventListener('DOMContentLoaded', function(){
        const toggle = document.getElementById('themeToggle');
        const icon = toggle ? toggle.querySelector('.theme-icon') : null;
        function updateIcon() {
            const t = document.documentElement.getAttribute('data-theme');
            if(icon) icon.textContent = t === 'dark' ? '☀️' : '🌙';
            document.querySelectorAll('.theme-logo').forEach(img => {
                img.src = t === 'dark' ? '/images/logo-dark.png' : '/images/logo-light.png';
            });
        }
        updateIcon();
        if(toggle) toggle.addEventListener('click', function(){
            const cur = document.documentElement.getAttribute('data-theme');
            const next = cur === 'dark' ? 'light' : 'dark';
            document.documentElement.setAttribute('data-theme', next);
            localStorage.setItem('roomie-theme', next);
            updateIcon();
        });
        // Mobile toggle
        const navToggle = document.getElementById('navToggle');
        const navMenu = document.getElementById('navMenu');
        if(navToggle) navToggle.addEventListener('click', function(){
            navMenu.classList.toggle('open');
        });
        // Scroll + glassmorphic navbar
        const nav = document.getElementById('mainNav');
        function applyScroll() {
            if (window.scrollY > 50) nav.classList.add('scrolled');
            else nav.classList.remove('scrolled');
        }
        window.addEventListener('scroll', applyScroll, { passive: true });
        // On non-home pages, apply frosted glass immediately (no hero behind nav)
        var path = window.location.pathname;
        if (path !== '/' && path !== '') {
            nav.classList.add('scrolled');
        }
    });
})();
</script>