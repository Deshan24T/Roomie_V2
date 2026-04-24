<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>Manage Rooms – Roomie Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
        :root{--bg:#060a12;--bg2:#0a1020;--surface:rgba(255,255,255,0.04);--surface2:rgba(255,255,255,0.07);--gold:#c9a84c;--gold-light:#e4c470;--text:#e2e8f0;--text-muted:#8ba3c2;--text-faint:#4a6285;--border:rgba(201,168,76,0.12);--radius:20px;--nav-height:70px;--shadow:0 8px 32px rgba(0,0,0,0.5);--glow:0 0 60px rgba(201,168,76,0.12);--glass-bg:rgba(255,255,255,0.04);--glass-border:rgba(255,255,255,0.08);--glass-blur:blur(24px);}
        [data-theme="light"]{--bg:#f0f4f8;--bg2:#e8edf5;--surface:rgba(255,255,255,0.7);--surface2:rgba(255,255,255,0.85);--text:#1e293b;--text-muted:#4b6080;--text-faint:#8ea3bf;--border:rgba(30,58,95,0.1);--shadow:0 8px 32px rgba(0,0,0,0.08);--glass-bg:rgba(255,255,255,0.5);--glass-border:rgba(30,58,95,0.1);--glass-blur:blur(20px);}
        body{font-family:'Plus Jakarta Sans',sans-serif;background:var(--bg);color:var(--text);padding-top:var(--nav-height);overflow-x:hidden;transition:background .5s,color .5s;}
        .container{max-width:1300px;margin:0 auto;padding:2.5rem 1.5rem;}
        .page-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:2rem;animation:fadeUp .7s ease both;}
        .page-title{font-family:'Outfit',sans-serif;font-size:1.8rem;}
        .btn-add{padding:.6rem 1.4rem;background:linear-gradient(135deg,var(--gold),var(--gold-light));color:#0a0e18;border-radius:20px;text-decoration:none;font-weight:700;font-size:.88rem;transition:all .3s;box-shadow:0 4px 15px rgba(201,168,76,.3);}
        .btn-add:hover{transform:translateY(-2px);box-shadow:0 6px 25px rgba(201,168,76,.4);}
        .flash{padding:.85rem 1rem;border-radius:12px;margin-bottom:1.5rem;font-size:.86rem;border-left:4px solid;backdrop-filter:blur(12px);}
        .flash-success{background:rgba(22,163,74,.1);border-color:#16a34a;color:#4ade80;}
        .card{background:var(--glass-bg);backdrop-filter:var(--glass-blur);border:1px solid var(--glass-border);border-radius:var(--radius);overflow:hidden;box-shadow:var(--shadow);position:relative;animation:fadeUp .8s .1s ease both;}
        .card::before{content:'';position:absolute;top:0;left:0;right:0;height:2px;background:linear-gradient(90deg,transparent,var(--gold),transparent);}
        .table-wrap{overflow-x:auto;}
        table{width:100%;border-collapse:collapse;font-size:.86rem;}
        th{text-align:left;padding:.8rem 1.2rem;background:var(--surface2);color:var(--gold);font-size:.74rem;letter-spacing:1px;text-transform:uppercase;font-weight:600;}
        td{padding:.9rem 1.2rem;border-bottom:1px solid rgba(201,168,76,.06);color:var(--text-muted);vertical-align:middle;}
        tr:last-child td{border-bottom:none;}
        tr:hover td{background:rgba(201,168,76,.03);}
        .room-img-thumb{width:60px;height:45px;object-fit:cover;border-radius:8px;}
        .type-badge{display:inline-block;padding:.2rem .7rem;border-radius:20px;font-size:.72rem;font-weight:600;background:rgba(201,168,76,.1);color:var(--gold);border:1px solid rgba(201,168,76,.25);}
        .badge-available{background:rgba(22,163,74,.1);color:#4ade80;}
        .badge-occupied{background:rgba(220,38,38,.1);color:#f87171;}
        .actions{display:flex;gap:.5rem;}
        .btn-edit{padding:.3rem .9rem;border:1px solid rgba(201,168,76,.35);color:var(--gold);border-radius:20px;font-size:.76rem;background:transparent;text-decoration:none;transition:all .3s;}
        .btn-edit:hover{background:rgba(201,168,76,.1);}
        .btn-del{padding:.3rem .9rem;border:1px solid rgba(220,38,38,.35);color:#f87171;border-radius:20px;font-size:.76rem;background:transparent;cursor:pointer;transition:all .2s;}
        .btn-del:hover{background:rgba(220,38,38,.1);}
        .no-data{text-align:center;padding:3rem;color:var(--text-faint);}
        .back-link{color:var(--gold);text-decoration:none;font-size:.85rem;display:inline-flex;align-items:center;gap:.4rem;margin-bottom:1.5rem;animation:fadeUp .6s ease both;}
        @keyframes fadeUp{from{opacity:0;transform:translateY(35px)}to{opacity:1;transform:translateY(0)}}
    </style>
</head>
<body>
<jsp:include page="../navbar.jsp"/>
<div class="container">
    <a href="/admin/dashboard" class="back-link">← Dashboard</a>
    <div class="page-header"><h1 class="page-title">Manage Rooms</h1><a href="/room/add" class="btn-add">+ Add Room</a></div>
    <c:if test="${not empty flash_success}"><div class="flash flash-success">${flash_success}</div></c:if>
    <div class="card">
        <c:choose>
            <c:when test="${empty rooms}"><div class="no-data">No rooms found. Add your first room!</div></c:when>
            <c:otherwise>
                <div class="table-wrap"><table><thead><tr><th>Photo</th><th>Room #</th><th>Type</th><th>Price/Night</th><th>Capacity</th><th>Description</th><th>Status</th><th>Actions</th></tr></thead><tbody>
                <c:forEach var="room" items="${rooms}"><tr>
                    <td><img src="/images/${room.imageFile}" class="room-img-thumb" alt="Room"></td>
                    <td>${room.roomNumber}</td><td><span class="type-badge">${room.displayType}</span></td>
                    <td>LKR ${room.pricePerNight}</td><td>${room.capacity}</td><td>${room.description}</td>
                    <td><span class="badge-${room.status.name().toLowerCase()}">${room.status}</span></td>
                    <td><div class="actions"><a href="/room/detail/${room.roomId}" style="color:var(--gold);font-size:.8rem;text-decoration:none;">View</a><a href="/room/edit/${room.roomId}" class="btn-edit">Edit</a><form action="/room/delete/${room.roomId}" method="post" onsubmit="return confirm('Delete room ${room.roomNumber}?')"><button type="submit" class="btn-del">Delete</button></form></div></td>
                </tr></c:forEach>
                </tbody></table></div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<script>(function(){var t=localStorage.getItem('roomie-theme')||'dark';document.documentElement.setAttribute('data-theme',t);})();</script>
</body>
</html>
