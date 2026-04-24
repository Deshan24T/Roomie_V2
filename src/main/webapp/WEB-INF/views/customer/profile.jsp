<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>My Profile – Roomie</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
        :root{--bg:#060a12;--bg2:#0a1020;--bg3:#0e1830;--surface:rgba(255,255,255,0.04);--surface2:rgba(255,255,255,0.07);--gold:#c9a84c;--gold-light:#e4c470;--gold-dark:#9a7a30;--text:#e2e8f0;--text-muted:#8ba3c2;--text-faint:#4a6285;--border:rgba(201,168,76,0.12);--radius:20px;--nav-height:70px;--shadow:0 8px 32px rgba(0,0,0,0.5);--glow:0 0 60px rgba(201,168,76,0.12);--glass-bg:rgba(255,255,255,0.04);--glass-border:rgba(255,255,255,0.08);--glass-blur:blur(24px);}
        [data-theme="light"]{--bg:#f0f4f8;--bg2:#e8edf5;--bg3:#dde5f0;--surface:rgba(255,255,255,0.7);--surface2:rgba(255,255,255,0.85);--text:#1e293b;--text-muted:#4b6080;--text-faint:#8ea3bf;--border:rgba(30,58,95,0.1);--shadow:0 8px 32px rgba(0,0,0,0.08);--glow:0 0 60px rgba(201,168,76,0.08);--glass-bg:rgba(255,255,255,0.5);--glass-border:rgba(30,58,95,0.1);--glass-blur:blur(20px);}
        html{scroll-behavior:smooth;}
        body{font-family:'Plus Jakarta Sans', sans-serif;background:var(--bg);color:var(--text);padding-top:var(--nav-height);overflow-x:hidden;transition:background 0.5s,color 0.5s;}

        .hero-bar{position:relative;background:linear-gradient(135deg,var(--bg2),var(--bg3));border-bottom:1px solid var(--border);padding:3.5rem 1.5rem;text-align:center;overflow:hidden;}
        .hero-bar::before{content:'';position:absolute;inset:0;background:radial-gradient(ellipse at 50% 0%,rgba(201,168,76,0.1) 0%,transparent 60%);pointer-events:none;}
        [data-theme="light"] .hero-bar{background:linear-gradient(135deg,#1e3a5f,#2e5fa3);}
        [data-theme="light"] .hero-bar .profile-name,[data-theme="light"] .hero-bar .profile-email{color:#fff;}
        [data-theme="light"] .hero-bar .profile-email{color:rgba(255,255,255,0.7);}
        .avatar-circle{width:80px;height:80px;border-radius:50%;background:linear-gradient(135deg,var(--gold-dark),var(--gold));display:flex;align-items:center;justify-content:center;font-size:2rem;font-weight:700;color:#0a0e18;margin:0 auto 1rem;box-shadow:0 4px 25px rgba(201,168,76,0.35);position:relative;animation:fadeUp 0.6s ease both;}
        .profile-name{font-family:'Outfit', sans-serif;font-size:1.8rem;font-weight:700;color:var(--text);position:relative;animation:fadeUp 0.6s 0.1s ease both;}
        .profile-email{color:var(--text-muted);font-size:0.9rem;margin-top:0.3rem;position:relative;animation:fadeUp 0.6s 0.2s ease both;}

        .container{max-width:1100px;margin:0 auto;padding:3rem 1.5rem;}
        .grid{display:grid;grid-template-columns:1fr 1.8fr;gap:2rem;align-items:start;}
        @media(max-width:800px){.grid{grid-template-columns:1fr;}}

        .card{background:var(--glass-bg);backdrop-filter:var(--glass-blur);-webkit-backdrop-filter:var(--glass-blur);border:1px solid var(--glass-border);border-radius:var(--radius);padding:2rem;box-shadow:var(--shadow);position:relative;overflow:hidden;animation:fadeUp 0.7s 0.15s ease both;}
        .card::before{content:'';position:absolute;top:0;left:0;right:0;height:2px;background:linear-gradient(90deg, transparent, var(--gold), transparent);}
        .card-title{font-family:'Outfit', sans-serif;font-size:1.1rem;font-weight:600;color:var(--gold);margin-bottom:1.5rem;padding-bottom:0.8rem;border-bottom:1px solid var(--border);display:flex;align-items:center;justify-content:space-between;}

        .info-row{display:flex;justify-content:space-between;align-items:center;padding:0.7rem 0;border-bottom:1px solid rgba(201,168,76,0.06);}
        .info-row:last-child{border-bottom:none;}
        .info-label{font-size:0.8rem;color:var(--text-muted);font-weight:500;}
        .info-val{font-size:0.88rem;color:var(--text);}
        .info-val.readonly{color:var(--text-faint);font-style:italic;}

        .edit-form{display:none;}
        .edit-form.active{display:block;}
        .view-mode.hidden{display:none;}
        .form-group{margin-bottom:1.1rem;}
        .form-group label{display:block;font-size:0.78rem;color:var(--text-muted);margin-bottom:0.4rem;font-weight:500;}
        .form-group input{width:100%;padding:0.7rem 1rem;border-radius:12px;border:1.5px solid var(--border);background:rgba(8,14,26,0.5);color:var(--text);font-size:0.9rem;font-family:'Plus Jakarta Sans',sans-serif;transition:border-color 0.3s,box-shadow 0.3s;}
        [data-theme="light"] .form-group input{background:#f0f4f8;}
        .form-group input:focus{outline:none;border-color:var(--gold);box-shadow:0 0 0 3px rgba(201,168,76,0.12);}
        .form-group input[readonly]{opacity:0.5;cursor:not-allowed;}
        .form-row{display:grid;grid-template-columns:1fr 1fr;gap:0.8rem;}
        @media(max-width:480px){.form-row{grid-template-columns:1fr;}}
        .btn-save{padding:0.75rem 2rem;background:linear-gradient(135deg, var(--gold), var(--gold-light));color:#0a0e18;border:none;border-radius:25px;font-weight:700;font-size:0.92rem;cursor:pointer;transition:all 0.4s cubic-bezier(0.23,1,0.32,1);box-shadow:0 4px 15px rgba(201,168,76,0.3);}
        .btn-save:hover{transform:translateY(-2px);box-shadow:0 6px 25px rgba(201,168,76,0.4);}
        .btn-cancel-edit{padding:0.75rem 1.5rem;background:transparent;border:1.5px solid var(--border);color:var(--text-muted);border-radius:25px;font-size:0.88rem;cursor:pointer;transition:all 0.3s;margin-left:0.7rem;}
        .btn-cancel-edit:hover{border-color:var(--gold);color:var(--gold);}
        .btn-edit{font-size:0.78rem;padding:0.35rem 1rem;background:transparent;border:1.5px solid var(--gold);color:var(--gold);border-radius:20px;cursor:pointer;transition:all 0.3s;font-family:'Plus Jakarta Sans',sans-serif;}
        .btn-edit:hover{background:rgba(201,168,76,0.1);}
        .form-actions{display:flex;align-items:center;margin-top:1.2rem;flex-wrap:wrap;gap:0.5rem;}

        .flash{padding:0.85rem 1.2rem;border-radius:12px;margin-bottom:1.2rem;font-size:0.88rem;border-left:4px solid;backdrop-filter:blur(12px);}
        .flash-success{background:rgba(22,163,74,0.1);border-color:#16a34a;color:#4ade80;}
        .flash-error{background:rgba(220,38,38,0.1);border-color:#dc2626;color:#f87171;}

        .no-data{text-align:center;padding:2.5rem;color:var(--text-muted);}
        .no-data a{color:var(--gold);text-decoration:none;font-weight:600;transition:color 0.2s;}
        .no-data a:hover{color:var(--gold-light);}
        @keyframes fadeUp { from { opacity:0; transform:translateY(35px); } to { opacity:1; transform:translateY(0); } }
    </style>
</head>
<body>
<jsp:include page="../navbar.jsp"/>

<div class="hero-bar">
    <div class="avatar-circle">${customer.firstName.charAt(0)}</div>
    <div class="profile-name">${customer.fullName}</div>
    <div class="profile-email">${customer.email}</div>
</div>

<div class="container">
    <c:if test="${not empty profileSuccess}"><div class="flash flash-success">✓ ${profileSuccess}</div></c:if>
    <c:if test="${not empty profileError}"><div class="flash flash-error">⚠ ${profileError}</div></c:if>

    <div class="grid">
        <div class="card">
            <div class="card-title">
                Account Details
                <button class="btn-edit" id="editToggleBtn" onclick="toggleEdit()">✏ Edit</button>
            </div>

            <div class="view-mode" id="viewMode">
                <div class="info-row"><span class="info-label">First Name</span><span class="info-val">${customer.firstName}</span></div>
                <div class="info-row"><span class="info-label">Last Name</span><span class="info-val">${customer.lastName}</span></div>
                <div class="info-row"><span class="info-label">Email</span><span class="info-val">${customer.email}</span></div>
                <div class="info-row"><span class="info-label">Phone</span><span class="info-val">${customer.phone}</span></div>
                <div class="info-row"><span class="info-label">Address</span><span class="info-val">${customer.address}</span></div>
                <div class="info-row"><span class="info-label">Member Since</span><span class="info-val readonly">${customer.registeredDate}</span></div>
                <div class="info-row"><span class="info-label">Role</span><span class="info-val readonly">${customer.role}</span></div>
            </div>

            <form class="edit-form" id="editForm" action="/customer/update" method="post">
                <div class="form-row">
                    <div class="form-group"><label for="firstName">First Name</label><input type="text" id="firstName" name="firstName" value="${customer.firstName}" required></div>
                    <div class="form-group"><label for="lastName">Last Name</label><input type="text" id="lastName" name="lastName" value="${customer.lastName}" required></div>
                </div>
                <div class="form-group"><label for="email">Email</label><input type="email" id="email" name="email" value="${customer.email}" required></div>
                <div class="form-group"><label for="phone">Phone</label><input type="text" id="phone" name="phone" value="${customer.phone}"></div>
                <div class="form-group"><label for="address">Address</label><input type="text" id="address" name="address" value="${customer.address}"></div>
                <div class="form-group"><label>Member Since (read-only)</label><input type="text" value="${customer.registeredDate}" readonly></div>
                <div class="form-group"><label>Role (read-only)</label><input type="text" value="${customer.role}" readonly></div>
                <hr style="border:none;border-top:1px solid var(--border);margin:1.2rem 0;">
                <p style="font-size:0.8rem;color:var(--text-muted);margin-bottom:0.8rem;">Change Password <span style="color:var(--text-faint)">(leave blank to keep current)</span></p>
                <div class="form-group"><label for="newPassword">New Password</label><input type="password" id="newPassword" name="newPassword" placeholder="••••••••" minlength="6"></div>
                <div class="form-actions">
                    <button type="submit" class="btn-save">Save Changes</button>
                    <button type="button" class="btn-cancel-edit" onclick="toggleEdit()">Cancel</button>
                </div>
            </form>
        </div>

        <div class="card" style="animation-delay:0.25s;">
            <div class="card-title">My Booking History</div>
            <a href="/reservation/my" style="color:var(--gold);font-size:0.85rem;text-decoration:none;">View full booking page →</a>
            <br><br>
            <div class="no-data">
                <p>Visit <a href="/reservation/my">My Bookings</a> to see all your reservations.</p>
            </div>
        </div>
    </div>
</div>

<script>
const t = localStorage.getItem('roomie-theme') || 'dark';
document.documentElement.setAttribute('data-theme', t);

function toggleEdit() {
    const view = document.getElementById('viewMode');
    const form = document.getElementById('editForm');
    const btn  = document.getElementById('editToggleBtn');
    const isEditing = form.classList.contains('active');
    if (isEditing) {
        form.classList.remove('active');
        view.classList.remove('hidden');
        btn.textContent = '✏ Edit';
    } else {
        form.classList.add('active');
        view.classList.add('hidden');
        btn.textContent = '✕ Cancel';
    }
}
<c:if test="${not empty profileError}">
toggleEdit();
</c:if>
</script>
</body>
</html>
