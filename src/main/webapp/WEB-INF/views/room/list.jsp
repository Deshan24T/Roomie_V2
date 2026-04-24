<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Rooms – Roomie</title>
    <meta name="view-transition" content="same-origin" />
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin:0; padding:0; }
        :root {
            --bg:#060a12;--bg2:#0a1020;--bg3:#0e1830;
            --surface:rgba(255,255,255,0.04);--surface2:rgba(255,255,255,0.07);
            --gold:#c9a84c;--gold-light:#e4c470;--gold-dark:#9a7a30;
            --text:#e2e8f0;--text-muted:#8ba3c2;--text-faint:#4a6285;
            --border:rgba(201,168,76,0.12);--border2:rgba(255,255,255,0.08);
            --radius:20px;--nav-height:70px;
            --shadow:0 8px 32px rgba(0,0,0,0.5);
            --glow:0 0 60px rgba(201,168,76,0.12);
            --glass-bg:rgba(255,255,255,0.04);--glass-border:rgba(255,255,255,0.08);--glass-blur:blur(24px);
        }
        [data-theme="light"] {
            --bg:#f0f4f8;--bg2:#e8edf5;--bg3:#dde5f0;
            --surface:rgba(255,255,255,0.7);--surface2:rgba(255,255,255,0.85);
            --text:#1e293b;--text-muted:#4b6080;--text-faint:#8ea3bf;
            --border:rgba(30,58,95,0.1);--border2:rgba(30,58,95,0.08);
            --shadow:0 8px 32px rgba(0,0,0,0.08);
            --glow:0 0 60px rgba(201,168,76,0.08);
            --glass-bg:rgba(255,255,255,0.5);--glass-border:rgba(30,58,95,0.1);--glass-blur:blur(20px);
        }
        html { scroll-behavior: smooth; }
        body { font-family:'Plus Jakarta Sans', sans-serif; background:var(--bg); color:var(--text); padding-top:var(--nav-height); overflow-x:hidden; transition: background 0.5s, color 0.5s; }

        /* Hero */
        .page-hero {
            position:relative; padding:5rem 1.5rem 4rem; text-align:center;
            border-bottom:1px solid var(--border);
            background: linear-gradient(135deg, var(--bg2), var(--bg3));
            overflow:hidden;
        }
        .page-hero::before {
            content:''; position:absolute; inset:0;
            background: radial-gradient(ellipse at 50% 0%, rgba(201,168,76,0.1) 0%, transparent 60%),
                        radial-gradient(ellipse at 80% 100%, rgba(100,150,220,0.05) 0%, transparent 50%);
            pointer-events:none;
        }
        [data-theme="light"] .page-hero { background: linear-gradient(135deg, #1e3a5f, #2e5fa3); }
        [data-theme="light"] .page-title, [data-theme="light"] .page-sub { color:#fff; }
        .page-title {
            font-family:'Outfit', sans-serif; font-size:clamp(2rem,5vw,3rem); font-weight:700;
            color:var(--text); margin-bottom:0.5rem; position:relative;
            animation: fadeUp 0.8s ease both;
        }
        .page-sub { color:var(--text-muted); font-size:1rem; position:relative; animation: fadeUp 0.8s 0.15s ease both; }

        /* Filter */
        .filter-bar {
            background:var(--glass-bg); backdrop-filter:var(--glass-blur); -webkit-backdrop-filter:var(--glass-blur);
            border-bottom:1px solid var(--glass-border); padding:1.2rem 1.5rem;
            position:sticky; top:var(--nav-height); z-index:100;
        }
        .filter-inner { max-width:1300px; margin:0 auto; display:flex; gap:1rem; align-items:center; flex-wrap:wrap; }
        .filter-label { font-size:0.82rem; color:var(--text-muted); white-space:nowrap; }
        .filter-btn {
            padding:0.4rem 1.1rem; border-radius:25px; font-size:0.84rem; font-weight:500;
            text-decoration:none; color:var(--text-muted); border:1.5px solid var(--border);
            background:transparent; cursor:pointer; transition:all 0.3s cubic-bezier(0.23,1,0.32,1);
        }
        .filter-btn:hover, .filter-btn.active { background:var(--gold); color:#0f172a; border-color:var(--gold); }

        /* Container */
        .container { max-width:1300px; margin:0 auto; padding:3rem 1.5rem; }

        /* Rooms grid */
        .rooms-grid { display:grid; grid-template-columns:repeat(auto-fill,minmax(340px,1fr)); gap:2rem; }
        .room-card {
            background:var(--glass-bg); backdrop-filter:var(--glass-blur); -webkit-backdrop-filter:var(--glass-blur);
            border-radius:var(--radius); overflow:hidden; border:1px solid var(--glass-border);
            transition: transform 0.5s cubic-bezier(0.23,1,0.32,1),
                        box-shadow 0.5s cubic-bezier(0.23,1,0.32,1),
                        border-color 0.4s;
            position:relative;
        }
        .room-card::before {
            content:''; position:absolute; top:0; left:0; right:0; height:2px;
            background:linear-gradient(90deg, transparent, var(--gold), transparent);
            opacity:0; transition:opacity 0.4s;
        }
        .room-card:hover {
            transform:translateY(-10px) scale(1.01);
            box-shadow:0 20px 50px rgba(0,0,0,0.4), var(--glow);
            border-color:rgba(201,168,76,0.35);
        }
        .room-card:hover::before { opacity:1; }
        .room-img-wrap { position:relative; height:240px; overflow:hidden; }
        .room-img { width:100%; height:100%; object-fit:cover; transition:transform 0.8s cubic-bezier(0.23,1,0.32,1); }
        .room-card:hover .room-img { transform:scale(1.08); }
        .room-badge { position:absolute; top:1rem; left:1rem; background:rgba(201,168,76,0.9); color:#0f172a; padding:0.3rem 0.9rem; border-radius:20px; font-size:0.74rem; font-weight:700; letter-spacing:1px; text-transform:uppercase; }
        .room-avail { position:absolute; top:1rem; right:1rem; background:rgba(22,163,74,0.85); color:#fff; padding:0.28rem 0.8rem; border-radius:20px; font-size:0.72rem; font-weight:600; backdrop-filter:blur(8px); }
        .room-avail.no { background:rgba(220,38,38,0.85); }
        .room-body { padding:1.4rem 1.6rem 1.6rem; }
        .room-num { font-size:0.76rem; color:var(--text-faint); margin-bottom:0.3rem; letter-spacing:2px; font-weight:500; }
        .room-name { font-family:'Outfit', sans-serif; font-size:1.25rem; font-weight:600; color:var(--text); margin-bottom:0.5rem; }
        .room-desc { font-size:0.86rem; color:var(--text-muted); margin-bottom:1rem; line-height:1.6; }
        .amenities { display:flex; flex-wrap:wrap; gap:0.35rem; margin-bottom:1.2rem; }
        .tag { background:rgba(201,168,76,0.08); border:1px solid rgba(201,168,76,0.18); color:var(--gold); border-radius:20px; padding:0.2rem 0.65rem; font-size:0.7rem; font-weight:500; }
        .room-foot { display:flex; align-items:center; justify-content:space-between; }
        .price { color:var(--gold); }
        .price strong { font-family:'Outfit', sans-serif; font-size:1.4rem; }
        .price span { font-size:0.78rem; color:var(--text-muted); }
        .cap { font-size:0.8rem; color:var(--text-muted); margin-top:0.25rem; }
        .btn-view {
            padding:0.55rem 1.4rem; border:1.5px solid rgba(201,168,76,0.4); color:var(--gold);
            border-radius:25px; font-size:0.82rem; font-weight:600; text-decoration:none;
            transition:all 0.3s cubic-bezier(0.23,1,0.32,1); backdrop-filter:blur(8px);
        }
        .btn-view:hover { background:var(--gold); color:#0a0e18; border-color:var(--gold); transform:scale(1.05); }
        .empty { text-align:center; padding:4rem; color:var(--text-muted); border:1px dashed var(--border); border-radius:var(--radius); background:var(--glass-bg); backdrop-filter:var(--glass-blur); }

        /* Reveal animation */
        .reveal { opacity:0; transform:translateY(40px); transition: opacity 0.9s cubic-bezier(0.23,1,0.32,1), transform 0.9s cubic-bezier(0.23,1,0.32,1); }
        .reveal.visible { opacity:1; transform:translateY(0); }
        @keyframes fadeUp { from { opacity:0; transform:translateY(35px); } to { opacity:1; transform:translateY(0); } }
        @media (max-width:768px) { .rooms-grid { grid-template-columns:1fr; } }
    </style>
</head>
<body>
<jsp:include page="../navbar.jsp"/>

<div class="page-hero">
    <h1 class="page-title">Our Rooms</h1>
    <p class="page-sub">From Coastal retreats to Jungle canopy suites — every room tells a story</p>
</div>

<div class="filter-bar">
    <div class="filter-inner">
        <span class="filter-label">Filter:</span>
        <a href="/room/list" class="filter-btn ${empty selectedType ? 'active' : ''}">All Rooms</a>
        <a href="/room/list?type=Standard" class="filter-btn ${'Standard' == selectedType ? 'active' : ''}">🌊 Coastal</a>
        <a href="/room/list?type=Deluxe" class="filter-btn ${'Deluxe' == selectedType ? 'active' : ''}">⛰️ Hill Country</a>
        <a href="/room/list?type=Suite" class="filter-btn ${'Suite' == selectedType ? 'active' : ''}">🌴 Jungle</a>
    </div>
</div>

<div class="container">
    <c:choose>
        <c:when test="${empty rooms}">
            <div class="empty"><p>No rooms found. Try a different filter.</p></div>
        </c:when>
        <c:otherwise>
            <div class="rooms-grid">
                <c:forEach var="room" items="${rooms}" varStatus="loop">
                    <div class="room-card reveal" style="view-transition-name: room-card-\${room.roomId}; transition-delay: ${loop.index * 0.1}s;">
                        <div class="room-img-wrap" style="view-transition-name: room-image-\${room.roomId};">
                            <img src="/images/${room.imageFile}" alt="${room.displayType} Room" class="room-img" loading="lazy">
                            <span class="room-badge">${room.displayType}</span>
                            <span class="room-avail ${room.status != 'AVAILABLE' ? 'no' : ''}">
                                ${room.status == 'AVAILABLE' ? 'Available' : 'Occupied'}
                            </span>
                        </div>
                        <div class="room-body">
                            <div class="room-num">ROOM ${room.roomNumber}</div>
                            <div class="room-name">${room.displayType} Room</div>
                            <div class="room-desc">${room.description} view — ideal for a relaxing getaway.</div>
                            <div class="amenities">
                                <c:forEach var="a" items="${room.amenities}">
                                    <span class="tag">${a}</span>
                                </c:forEach>
                            </div>
                            <div class="room-foot">
                                <div>
                                    <div class="price"><strong>LKR ${room.pricePerNight}</strong><span>/night</span></div>
                                    <div class="cap">👥 Up to ${room.capacity} guests</div>
                                </div>
                                <a href="/room/detail/${room.roomId}" class="btn-view">View Details</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>
<script>
const t=localStorage.getItem('roomie-theme')||'dark';
document.documentElement.setAttribute('data-theme',t);
// Scroll reveal
var revealObserver = new IntersectionObserver(function(entries) {
    entries.forEach(function(e) { if (e.isIntersecting) e.target.classList.add('visible'); });
}, { threshold: 0.1 });
document.querySelectorAll('.reveal').forEach(function(el) { revealObserver.observe(el); });
</script>
</body>
</html>
