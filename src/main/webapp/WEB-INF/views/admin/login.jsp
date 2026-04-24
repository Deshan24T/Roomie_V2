<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en" data-theme="dark">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width,initial-scale=1.0">
            <title>Admin Login – Roomie</title>
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
                    --surface: rgba(255, 255, 255, 0.04);
                    --gold: #c9a84c;
                    --gold-light: #e4c470;
                    --text: #e2e8f0;
                    --text-muted: #8ba3c2;
                    --border: rgba(201, 168, 76, 0.12);
                    --nav-height: 70px;
                    --shadow: 0 8px 32px rgba(0, 0, 0, 0.5);
                    --glass-bg: rgba(255, 255, 255, 0.04);
                    --glass-border: rgba(255, 255, 255, 0.08);
                    --glass-blur: blur(24px);
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
                    transition: background .5s, color .5s;
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
                    background: radial-gradient(ellipse at 50% 0%, rgba(201, 168, 76, .06) 0%, transparent 60%), radial-gradient(ellipse at 80% 100%, rgba(100, 150, 220, .03) 0%, transparent 50%);
                    pointer-events: none;
                }

                .auth-card {
                    background: var(--glass-bg);
                    backdrop-filter: var(--glass-blur);
                    border: 1px solid var(--glass-border);
                    border-radius: 24px;
                    padding: 3rem;
                    width: 100%;
                    max-width: 420px;
                    box-shadow: var(--shadow);
                    position: relative;
                    overflow: hidden;
                    animation: fadeUp .7s ease both;
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
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    text-align: center;
                    margin-bottom: 2rem;
                }

                .badge-admin {
                    display: inline-block;
                    background: rgba(201, 168, 76, .1);
                    border: 1px solid rgba(201, 168, 76, .25);
                    color: var(--gold);
                    border-radius: 25px;
                    padding: .3rem 1rem;
                    font-size: .74rem;
                    letter-spacing: 2px;
                    text-transform: uppercase;
                    font-weight: 600;
                    margin-bottom: 1rem;
                }

                .auth-subtitle {
                    color: var(--text-muted);
                    font-size: .85rem;
                    margin-top: .3rem;
                }

                .form-group {
                    margin-bottom: 1.2rem;
                }

                label {
                    display: block;
                    font-size: .8rem;
                    color: var(--text-muted);
                    margin-bottom: .5rem;
                    font-weight: 500;
                }

                input {
                    width: 100%;
                    padding: .8rem 1rem;
                    border-radius: 12px;
                    border: 1.5px solid var(--border);
                    background: rgba(8, 14, 26, .5);
                    color: var(--text);
                    font-size: .92rem;
                    transition: border-color .3s, box-shadow .3s;
                }

                input:focus {
                    outline: none;
                    border-color: var(--gold);
                    box-shadow: 0 0 0 3px rgba(201, 168, 76, .12);
                }

                .btn-auth {
                    width: 100%;
                    padding: .9rem;
                    background: linear-gradient(135deg, var(--gold), var(--gold-light));
                    color: #0a0e18;
                    border: none;
                    border-radius: 25px;
                    font-size: 1rem;
                    font-weight: 700;
                    cursor: pointer;
                    transition: all .4s cubic-bezier(.23, 1, .32, 1);
                    margin-top: .5rem;
                    box-shadow: 0 4px 25px rgba(201, 168, 76, .35);
                }

                .btn-auth:hover {
                    transform: translateY(-3px) scale(1.02);
                    box-shadow: 0 8px 40px rgba(201, 168, 76, .5);
                }

                .auth-footer {
                    text-align: center;
                    margin-top: 1.5rem;
                    font-size: .85rem;
                    color: var(--text-muted);
                }

                .auth-footer a {
                    color: var(--gold);
                    text-decoration: none;
                    transition: color .2s;
                }

                .flash {
                    padding: .85rem 1rem;
                    border-radius: 12px;
                    margin-bottom: 1.2rem;
                    font-size: .86rem;
                    border-left: 4px solid;
                    backdrop-filter: blur(12px);
                }

                .flash-error {
                    background: rgba(220, 38, 38, .1);
                    border-color: #dc2626;
                    color: #f87171;
                }

                .hint {
                    background: rgba(201, 168, 76, .06);
                    border: 1px dashed rgba(201, 168, 76, .15);
                    border-radius: 12px;
                    padding: .8rem 1rem;
                    font-size: .79rem;
                    color: var(--text-muted);
                    margin-top: 1rem;
                }

                .hint strong {
                    color: var(--gold);
                }

                @keyframes fadeUp {
                    from {
                        opacity: 0;
                        transform: translateY(35px)
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0)
                    }
                }
            </style>
        </head>

        <body>
            <div class="auth-page">
                <div class="auth-card">
                    <div class="auth-logo">
                        <div class="badge-admin">Admin Access</div>
                        <img src="/images/logo-dark.png" alt="Roomie Admin Logo"
                            style="height:55px;width:auto;object-fit:contain;margin:.5rem 0;">
                        <div class="auth-subtitle">Secure administrator portal</div>
                    </div>
                    <c:if test="${not empty flash_error}">
                        <div class="flash flash-error">${flash_error}</div>
                    </c:if>
                    <form action="/admin/login" method="post">
                        <div class="form-group"><label for="email">Admin Email</label><input type="email" id="email"
                                name="email" placeholder="••••••••@roomie.lk" required></div>
                        <div class="form-group"><label for="password">Password</label><input type="password"
                                id="password" name="password" placeholder="••••••••" required></div>
                        <button type="submit" class="btn-auth">Access Dashboard →</button>
                    </form>
                    <div class="auth-footer"><a href="/customer/login">← Customer Login</a></div>
                </div>
            </div>
            <script>document.documentElement.setAttribute('data-theme', 'dark');</script>
        </body>

        </html>