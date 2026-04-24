<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en" data-theme="dark">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width,initial-scale=1.0">
            <title>Customer Login – Roomie</title>
            <link
                href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap"
                rel="stylesheet">
            <style>
                *,
                *::before,
                *::after {
                    box-sizing: border-box;
                    margin: 0;
                    padding: 0;
                }

                :root {
                    --bg: #060a12;
                    --bg2: #0a1020;
                    --surface: rgba(255, 255, 255, 0.04);
                    --gold: #c9a84c;
                    --gold-light: #e4c470;
                    --text: #e2e8f0;
                    --text-muted: #8ba3c2;
                    --border: rgba(201, 168, 76, 0.12);
                    --nav-height: 70px;
                    --glass-bg: rgba(255, 255, 255, 0.04);
                    --glass-border: rgba(255, 255, 255, 0.08);
                    --glass-blur: blur(24px);
                    --shadow: 0 8px 32px rgba(0, 0, 0, 0.5);
                    --glow: 0 0 60px rgba(201, 168, 76, 0.12);
                }

                [data-theme="light"] {
                    --bg: #f0f4f8;
                    --bg2: #e8edf5;
                    --surface: rgba(255, 255, 255, 0.7);
                    --text: #1e293b;
                    --text-muted: #4b6080;
                    --border: rgba(30, 58, 95, 0.1);
                    --glass-bg: rgba(255, 255, 255, 0.5);
                    --glass-border: rgba(30, 58, 95, 0.1);
                    --glass-blur: blur(20px);
                    --shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
                    --glow: 0 0 60px rgba(201, 168, 76, 0.08);
                }

                html {
                    scroll-behavior: smooth;
                }

                body {
                    font-family: 'Plus Jakarta Sans', sans-serif;
                    background: var(--bg);
                    color: var(--text);
                    padding-top: var(--nav-height);
                    min-height: 100vh;
                    display: flex;
                    flex-direction: column;
                    overflow-x: hidden;
                    transition: background 0.5s, color 0.5s;
                }

                .auth-page {
                    flex: 1;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    padding: 3rem 1.5rem;
                    position: relative;
                }

                .auth-page::before {
                    content: '';
                    position: absolute;
                    inset: 0;
                    background: radial-gradient(ellipse at 50% 0%, rgba(201, 168, 76, 0.08) 0%, transparent 60%), radial-gradient(ellipse at 80% 100%, rgba(100, 150, 220, 0.04) 0%, transparent 50%);
                    pointer-events: none;
                }

                .auth-card {
                    background: var(--glass-bg);
                    backdrop-filter: var(--glass-blur);
                    -webkit-backdrop-filter: var(--glass-blur);
                    border: 1px solid var(--glass-border);
                    border-radius: 24px;
                    padding: 3rem;
                    width: 100%;
                    max-width: 440px;
                    box-shadow: var(--shadow);
                    position: relative;
                    overflow: hidden;
                    animation: fadeUp 0.7s ease both;
                }

                .auth-card::before {
                    content: '';
                    position: absolute;
                    top: 0;
                    left: 0;
                    right: 0;
                    height: 2px;
                    background: linear-gradient(90deg, transparent, var(--gold), transparent);
                }

                .auth-logo {
                    text-align: center;
                    margin-bottom: 2rem;
                }

                .auth-logo-icon {
                    font-size: 2.5rem;
                    display: block;
                    margin-bottom: 0.5rem;
                }

                .auth-logo-title {
                    font-family: 'Outfit', sans-serif;
                    font-size: 1.8rem;
                    color: var(--gold);
                }

                .auth-subtitle {
                    color: var(--text-muted);
                    font-size: 0.88rem;
                    margin-top: 0.3rem;
                }

                h2 {
                    font-family: 'Outfit', sans-serif;
                    font-size: 1.5rem;
                    font-weight: 700;
                    margin-bottom: 1.8rem;
                    color: var(--text);
                }

                .form-group {
                    margin-bottom: 1.2rem;
                }

                label {
                    display: block;
                    font-size: 0.8rem;
                    color: var(--text-muted);
                    margin-bottom: 0.5rem;
                    font-weight: 500;
                }

                input {
                    width: 100%;
                    padding: 0.8rem 1rem;
                    border-radius: 12px;
                    border: 1.5px solid var(--border);
                    background: rgba(8, 14, 26, 0.5);
                    color: var(--text);
                    font-size: 0.92rem;
                    transition: border-color 0.3s, box-shadow 0.3s;
                }

                [data-theme="light"] input {
                    background: #f0f4f8;
                }

                input:focus {
                    outline: none;
                    border-color: var(--gold);
                    box-shadow: 0 0 0 3px rgba(201, 168, 76, 0.12);
                }

                .btn-auth {
                    width: 100%;
                    padding: 0.9rem;
                    background: linear-gradient(135deg, var(--gold), var(--gold-light));
                    color: #0a0e18;
                    border: none;
                    border-radius: 25px;
                    font-size: 1rem;
                    font-weight: 700;
                    cursor: pointer;
                    transition: all 0.4s cubic-bezier(0.23, 1, 0.32, 1);
                    margin-top: 0.5rem;
                    box-shadow: 0 4px 25px rgba(201, 168, 76, 0.35);
                    position: relative;
                    overflow: hidden;
                }

                .btn-auth::before {
                    content: '';
                    position: absolute;
                    inset: 0;
                    background: linear-gradient(135deg, var(--gold-light), #fff, var(--gold-light));
                    opacity: 0;
                    transition: opacity 0.4s;
                }

                .btn-auth:hover {
                    transform: translateY(-3px) scale(1.02);
                    box-shadow: 0 8px 40px rgba(201, 168, 76, 0.5);
                }

                .btn-auth:hover::before {
                    opacity: 0.15;
                }

                .auth-footer {
                    text-align: center;
                    margin-top: 1.5rem;
                    font-size: 0.86rem;
                    color: var(--text-muted);
                }

                .auth-footer a {
                    color: var(--gold);
                    text-decoration: none;
                    font-weight: 600;
                    transition: color 0.2s;
                }

                .auth-footer a:hover {
                    color: var(--gold-light);
                }

                .flash {
                    padding: 0.85rem 1rem;
                    border-radius: 12px;
                    margin-bottom: 1.2rem;
                    font-size: 0.86rem;
                    border-left: 4px solid;
                    backdrop-filter: blur(12px);
                }

                .flash-error {
                    background: rgba(220, 38, 38, 0.1);
                    border-color: #dc2626;
                    color: #f87171;
                }

                .flash-success {
                    background: rgba(22, 163, 74, 0.1);
                    border-color: #16a34a;
                    color: #4ade80;
                }

                .admin-link {
                    text-align: center;
                    margin-top: 1rem;
                    font-size: 0.8rem;
                    color: var(--text-muted);
                }

                .admin-link a {
                    color: var(--text-muted);
                    text-decoration: none;
                    border-bottom: 1px dashed var(--border);
                    transition: color 0.2s;
                }

                .admin-link a:hover {
                    color: var(--gold);
                }

                @keyframes fadeUp {
                    from {
                        opacity: 0;
                        transform: translateY(35px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }
            </style>
        </head>

        <body>
            <jsp:include page="../navbar.jsp" />

            <div class="auth-page">
                <div class="auth-card">
                    <div class="auth-logo">
                        <img src="/images/logo-dark.png" class="theme-logo" alt="Roomie Logo"
                            style="height: 55px; width: auto; object-fit: contain; margin-bottom: 0.5rem;">
                        <div class="auth-subtitle">Welcome back! Sign in to your account</div>

                    </div>

                    <c:if test="${not empty flash_error}">
                        <div class="flash flash-error">${flash_error}</div>
                    </c:if>
                    <c:if test="${not empty flash_success}">
                        <div class="flash flash-success">${flash_success}</div>
                    </c:if>

                    <form action="/customer/login" method="post">
                        <div class="form-group">
                            <label for="email">Email Address</label>
                            <input type="email" id="email" name="email" placeholder="you@example.com" required>
                        </div>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" id="password" name="password" placeholder="••••••••" required>
                        </div>
                        <button type="submit" class="btn-auth">Sign In →</button>
                    </form>
                    <div class="auth-footer">Don't have an account? <a href="/customer/register">Sign up free</a></div>
                    <div class="admin-link"><a href="/admin/login">Admin login →</a></div>
                </div>
            </div>
            <script>
                const t = localStorage.getItem('roomie-theme') || 'dark'; document.documentElement.setAttribute('data-theme', t);
                const err = '${flash_error}', suc = '${flash_success}';
            </script>
        </body>

        </html>