<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>Manage Customers – Roomie Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
        :root{--bg:#060a12;--bg2:#0a1020;--surface:rgba(255,255,255,0.04);--surface2:rgba(255,255,255,0.07);--gold:#c9a84c;--gold-light:#e4c470;--text:#e2e8f0;--text-muted:#8ba3c2;--text-faint:#4a6285;--border:rgba(201,168,76,0.12);--radius:20px;--nav-height:70px;--shadow:0 8px 32px rgba(0,0,0,0.5);--glass-bg:rgba(255,255,255,0.04);--glass-border:rgba(255,255,255,0.08);--glass-blur:blur(24px);}
        [data-theme="light"]{--bg:#f0f4f8;--bg2:#e8edf5;--surface:rgba(255,255,255,0.7);--surface2:rgba(255,255,255,0.85);--text:#1e293b;--text-muted:#4b6080;--text-faint:#8ea3bf;--border:rgba(30,58,95,0.1);--shadow:0 8px 32px rgba(0,0,0,0.08);--glass-bg:rgba(255,255,255,0.5);--glass-border:rgba(30,58,95,0.1);--glass-blur:blur(20px);}
        body{font-family:'Plus Jakarta Sans',sans-serif;background:var(--bg);color:var(--text);padding-top:var(--nav-height);overflow-x:hidden;transition:background .5s,color .5s;}
        .container{max-width:1200px;margin:0 auto;padding:2.5rem 1.5rem;}
        .back-link{color:var(--gold);text-decoration:none;font-size:.85rem;margin-bottom:1.5rem;display:inline-flex;align-items:center;gap:.4rem;animation:fadeUp .6s ease both;}
        .page-title{font-family:'Outfit',sans-serif;font-size:1.8rem;margin-bottom:2rem;animation:fadeUp .7s ease both;}
        .flash{padding:.85rem 1rem;border-radius:12px;margin-bottom:1.5rem;font-size:.86rem;border-left:4px solid;backdrop-filter:blur(12px);}
        .flash-success{background:rgba(22,163,74,.1);border-color:#16a34a;color:#4ade80;}
        .card{background:var(--glass-bg);backdrop-filter:var(--glass-blur);border:1px solid var(--glass-border);border-radius:var(--radius);overflow:hidden;box-shadow:var(--shadow);position:relative;animation:fadeUp .8s .1s ease both;}
        .card::before{content:'';position:absolute;top:0;left:0;right:0;height:2px;background:linear-gradient(90deg,transparent,var(--gold),transparent);}
        table{width:100%;border-collapse:collapse;font-size:.86rem;}
        th{text-align:left;padding:.8rem 1.2rem;background:var(--surface2);color:var(--gold);font-size:.72rem;letter-spacing:1px;text-transform:uppercase;font-weight:600;}
        td{padding:.85rem 1.2rem;border-bottom:1px solid rgba(201,168,76,.06);color:var(--text-muted);}
        tr:last-child td{border-bottom:none;}
        tr:hover td{background:rgba(201,168,76,.03);}
        .avatar{width:34px;height:34px;border-radius:50%;background:linear-gradient(135deg,#9a7a30,#c9a84c);display:flex;align-items:center;justify-content:center;font-weight:700;font-size:.8rem;color:#0a0e18;flex-shrink:0;}
        .name-cell{display:flex;align-items:center;gap:.8rem;}
        .btn-del{padding:.3rem .9rem;border:1px solid rgba(220,38,38,.35);color:#f87171;border-radius:20px;font-size:.76rem;background:transparent;cursor:pointer;transition:all .2s;}
        .btn-del:hover{background:rgba(220,38,38,.1);}
        .no-data{text-align:center;padding:3rem;color:var(--text-faint);}
        @keyframes fadeUp{from{opacity:0;transform:translateY(35px)}to{opacity:1;transform:translateY(0)}}
    </style>
</head>
<body>
<jsp:include page="../navbar.jsp"/>
<div class="container">
    <a href="/admin/dashboard" class="back-link">← Dashboard</a>
    <h1 class="page-title">All Customers</h1>
    <c:if test="${not empty flash_success}"><div class="flash flash-success">${flash_success}</div></c:if>
    <div class="card">
        <c:choose>
            <c:when test="${empty customers}"><div class="no-data">No customers registered yet.</div></c:when>
            <c:otherwise>
                <table><thead><tr><th>Name</th><th>Email</th><th>Phone</th><th>Address</th><th>Joined</th><th>Action</th></tr></thead><tbody>
                <c:forEach var="c" items="${customers}"><tr>
                    <td><div class="name-cell"><div class="avatar">${c.firstName.charAt(0)}</div><span>${c.fullName}</span></div></td>
                    <td>${c.email}</td><td>${c.phone}</td><td>${c.address}</td><td>${c.registeredDate}</td>
                    <td><form action="/admin/customers/delete/${c.id}" method="post" onsubmit="return confirm('Remove ${c.fullName}?')"><button type="submit" class="btn-del">Remove</button></form></td>
                </tr></c:forEach>
                </tbody></table>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<script>(function(){var t=localStorage.getItem('roomie-theme')||'dark';document.documentElement.setAttribute('data-theme',t);})();</script>
</body>
</html>
