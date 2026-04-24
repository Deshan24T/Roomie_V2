<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Room ${room.roomNumber} – Roomie</title>
    <meta name="view-transition" content="same-origin" />
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
        :root{
            --bg:#060a12;--bg2:#0a1020;--bg3:#0e1830;
            --surface:rgba(255,255,255,0.04);--surface2:rgba(255,255,255,0.07);
            --gold:#c9a84c;--gold-light:#e4c470;--gold-dark:#9a7a30;
            --text:#e2e8f0;--text-muted:#8ba3c2;--text-faint:#4a6285;
            --border:rgba(201,168,76,0.12);--border2:rgba(255,255,255,0.08);
            --radius:20px;--nav-height:70px;
            --shadow:0 8px 32px rgba(0,0,0,0.5);--glow:0 0 60px rgba(201,168,76,0.12);
            --glass-bg:rgba(255,255,255,0.04);--glass-border:rgba(255,255,255,0.08);--glass-blur:blur(24px);
        }
        [data-theme="light"]{
            --bg:#f0f4f8;--bg2:#e8edf5;--bg3:#dde5f0;
            --surface:rgba(255,255,255,0.7);--surface2:rgba(255,255,255,0.85);
            --text:#1e293b;--text-muted:#4b6080;--text-faint:#8ea3bf;
            --border:rgba(30,58,95,0.1);--border2:rgba(30,58,95,0.08);
            --shadow:0 8px 32px rgba(0,0,0,0.08);--glow:0 0 60px rgba(201,168,76,0.08);
            --glass-bg:rgba(255,255,255,0.5);--glass-border:rgba(30,58,95,0.1);--glass-blur:blur(20px);
        }
        html{scroll-behavior:smooth;}
        body{font-family:'Plus Jakarta Sans', sans-serif;background:var(--bg);color:var(--text);padding-top:var(--nav-height);overflow-x:hidden;transition:background 0.5s, color 0.5s;}
        .container{max-width:1100px;margin:0 auto;padding:3rem 1.5rem;}
        .back-link{color:var(--gold);text-decoration:none;font-size:0.87rem;display:inline-flex;align-items:center;gap:0.4rem;margin-bottom:2rem;transition:all 0.3s;animation:fadeUp 0.6s ease both;}
        .back-link:hover{opacity:0.7;gap:0.6rem;}
        .detail-grid{display:grid;grid-template-columns:1.2fr 1fr;gap:3rem;align-items:start;}
        @media(max-width:800px){.detail-grid{grid-template-columns:1fr;}}
        .img-gallery{border-radius:var(--radius);overflow:hidden;position:relative;box-shadow:var(--shadow);animation:fadeUp 0.7s ease both;}
        .main-img{width:100%;height:420px;object-fit:cover;transition:transform 0.8s cubic-bezier(0.23,1,0.32,1);}
        .img-gallery:hover .main-img{transform:scale(1.03);}
        .room-type-badge{position:absolute;top:1.2rem;left:1.2rem;background:rgba(201,168,76,0.9);color:#0f172a;padding:0.35rem 1rem;border-radius:20px;font-size:0.78rem;font-weight:700;letter-spacing:1px;text-transform:uppercase;}
        .info-panel{
            background:var(--glass-bg);backdrop-filter:var(--glass-blur);-webkit-backdrop-filter:var(--glass-blur);
            border:1px solid var(--glass-border);border-radius:var(--radius);padding:2.2rem;
            box-shadow:var(--shadow);position:relative;overflow:hidden;
            animation:fadeUp 0.8s 0.1s ease both;
        }
        .info-panel::before{
            content:'';position:absolute;top:0;left:0;right:0;height:2px;
            background:linear-gradient(90deg, transparent, var(--gold), transparent);
        }
        .room-tag{font-size:0.76rem;color:var(--gold);letter-spacing:2px;text-transform:uppercase;margin-bottom:0.5rem;}
        .room-title{font-family:'Outfit', sans-serif;font-size:2rem;font-weight:700;color:var(--text);margin-bottom:0.4rem;}
        .room-desc-full{color:var(--text-muted);font-size:0.9rem;line-height:1.7;margin-bottom:1.5rem;}
        .detail-row{display:flex;align-items:center;gap:0.6rem;color:var(--text-muted);font-size:0.88rem;margin-bottom:0.6rem;}
        .detail-icon{font-size:1.1rem;}
        .divider{border:none;border-top:1px solid var(--border);margin:1.5rem 0;}
        .amenities-title{font-size:0.78rem;letter-spacing:2px;text-transform:uppercase;color:var(--gold);margin-bottom:1rem;font-weight:600;}
        .amenities{display:flex;flex-wrap:wrap;gap:0.5rem;margin-bottom:1.5rem;}
        .amenity-tag{background:rgba(201,168,76,0.08);border:1px solid rgba(201,168,76,0.18);color:var(--gold);border-radius:20px;padding:0.3rem 0.85rem;font-size:0.78rem;font-weight:500;transition:all 0.2s;}
        .amenity-tag:hover{background:rgba(201,168,76,0.15);border-color:rgba(201,168,76,0.3);}
        .price-block{background:rgba(201,168,76,0.06);border:1px solid rgba(201,168,76,0.15);border-radius:16px;padding:1.5rem;margin-bottom:1.5rem;}
        .price-label{font-size:0.78rem;color:var(--text-muted);margin-bottom:0.3rem;}
        .price-val{font-family:'Outfit', sans-serif;font-size:2.2rem;font-weight:700;color:var(--gold);}
        .price-sub{font-size:0.8rem;color:var(--text-faint);}
        .book-form{display:flex;flex-direction:column;gap:1rem;}
        .form-row{display:grid;grid-template-columns:1fr 1fr;gap:1rem;}
        label{font-size:0.8rem;color:var(--text-muted);margin-bottom:0.3rem;display:block;}
        input[type=date]{width:100%;padding:0.7rem 1rem;border-radius:12px;border:1.5px solid var(--border);background:var(--bg2);color:var(--text);font-size:0.9rem;transition:border-color 0.3s,box-shadow 0.3s;}
        [data-theme="light"] input[type=date]{background:#f0f4f8;}
        input[type=date]:focus{outline:none;border-color:var(--gold);box-shadow:0 0 0 3px rgba(201,168,76,0.12);}
        .nights-preview{font-size:0.85rem;color:var(--text-muted);text-align:center;padding:0.5rem;}
        .btn-book{display:block;width:100%;padding:1rem;background:linear-gradient(135deg, var(--gold), var(--gold-light));color:#0a0e18;border:none;border-radius:25px;font-size:1rem;font-weight:700;cursor:pointer;transition:all 0.4s cubic-bezier(0.23,1,0.32,1);letter-spacing:0.5px;box-shadow:0 4px 25px rgba(201,168,76,0.35);}
        .btn-book:hover{transform:translateY(-3px) scale(1.02);box-shadow:0 8px 40px rgba(201,168,76,0.5);}
        .login-prompt{text-align:center;background:rgba(201,168,76,0.06);border:1px dashed rgba(201,168,76,0.25);border-radius:16px;padding:1.5rem;}
        .login-prompt p{color:var(--text-muted);margin-bottom:1rem;font-size:0.9rem;}
        .btn-gold-sm{padding:0.6rem 1.5rem;background:linear-gradient(135deg, var(--gold), var(--gold-light));color:#0a0e18;border-radius:25px;text-decoration:none;font-weight:700;font-size:0.88rem;transition:all 0.3s;box-shadow:0 4px 15px rgba(201,168,76,0.3);}
        .btn-gold-sm:hover{transform:translateY(-2px);box-shadow:0 6px 25px rgba(201,168,76,0.4);}
        .status-ok{display:inline-flex;align-items:center;gap:0.4rem;background:rgba(22,163,74,0.1);color:#4ade80;border:1px solid rgba(22,163,74,0.3);border-radius:20px;padding:0.3rem 0.9rem;font-size:0.78rem;font-weight:600;}
        .flash-msg{padding:1rem 1.5rem;border-radius:12px;margin-bottom:1rem;font-size:0.9rem;border-left:4px solid;backdrop-filter:blur(12px);}
        .flash-error{background:rgba(220,38,38,0.1);border-color:#dc2626;color:#f87171;}
        @keyframes fadeUp { from { opacity:0; transform:translateY(35px); } to { opacity:1; transform:translateY(0); } }
    </style>
</head>
<body>
<jsp:include page="../navbar.jsp"/>

<div class="container">
    <a href="/room/list" class="back-link">← Back to all rooms</a>

    <c:if test="${not empty flash_error}">
        <div class="flash-msg flash-error">${flash_error}</div>
    </c:if>

    <div class="detail-grid">
        <!-- Image -->
        <div class="img-gallery" style="view-transition-name: room-card-\${room.roomId};">
            <img src="/images/${room.imageFile}" alt="${room.displayType} Room" class="main-img" style="view-transition-name: room-image-\${room.roomId};">
            <span class="room-type-badge">${room.displayType}</span>
        </div>

        <!-- Info -->
        <div class="info-panel">
            <div class="room-tag">Room ${room.roomNumber}</div>
            <h1 class="room-title">${room.displayType} Room</h1>
            <p class="room-desc-full">${room.description} facing room with premium furnishings and modern amenities. Perfect for a relaxing stay in Sri Lanka.</p>

            <div class="detail-row"><span class="detail-icon">👥</span>Up to ${room.capacity} guests</div>
            <div class="detail-row"><span class="detail-icon">🏢</span>Floor ${room.roomNumber.length() > 2 ? room.roomNumber.charAt(0) : '1'}, Room ${room.roomNumber}</div>
            <div class="detail-row"><span class="detail-icon">✅</span>
                <c:if test="${room.available}"><span class="status-ok">🟢 Available</span></c:if>
                <c:if test="${!room.available}"><span style="color:#f87171;">Unavailable</span></c:if>
            </div>

            <hr class="divider">
            <div class="amenities-title">Included Amenities</div>
            <div class="amenities">
                <c:forEach var="a" items="${room.amenities}">
                    <span class="amenity-tag">${a}</span>
                </c:forEach>
            </div>

            <div class="price-block">
                <div class="price-label">Nightly Rate</div>
                <div class="price-val">LKR ${room.pricePerNight}</div>
                <div class="price-sub">per night · taxes included</div>
            </div>

            <c:choose>
                <c:when test="${room.available}">
                    <c:choose>
                        <c:when test="${not empty sessionScope.loggedCustomer}">
                            <form action="/reservation/book" method="post" class="book-form">
                                <input type="hidden" name="roomId" value="${room.roomId}">
                                <div class="form-row">
                                    <div>
                                        <label for="checkIn">Check-In</label>
                                        <input type="date" id="checkIn" name="checkIn" required>
                                    </div>
                                    <div>
                                        <label for="checkOut">Check-Out</label>
                                        <input type="date" id="checkOut" name="checkOut" required>
                                    </div>
                                </div>
                                <div class="nights-preview" id="nightsPreview">Select dates to see total price</div>
                                <button type="submit" class="btn-book">Book Now →</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <div class="login-prompt">
                                <p>Please log in to book this room</p>
                                <a href="/customer/login" class="btn-gold-sm">Login to Book</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <div class="login-prompt">
                        <p>This room is currently unavailable. Check back soon or browse other rooms.</p>
                        <a href="/room/list" class="btn-gold-sm">Browse Rooms</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script>
const t=localStorage.getItem('roomie-theme')||'dark';
document.documentElement.setAttribute('data-theme',t);

const ci = document.getElementById('checkIn');
const co = document.getElementById('checkOut');
const preview = document.getElementById('nightsPreview');
const today = new Date().toISOString().split('T')[0];
if(ci) { ci.min = today; co.min = today; }

function updatePreview() {
    if (!ci || !co || !ci.value || !co.value) return;
    const d1 = new Date(ci.value), d2 = new Date(co.value);
    const nights = Math.round((d2 - d1) / 86400000);
    if (nights <= 0) { preview.textContent = 'Check-out must be after check-in'; preview.style.color='#f87171'; return; }
    const total = nights * ${room.pricePerNight};
    preview.textContent = nights + ' night' + (nights>1?'s':'') + ' × LKR ${room.pricePerNight} = LKR ' + total.toLocaleString();
    preview.style.color = '#c9a84c';
}
if(ci) { ci.addEventListener('change', updatePreview); co.addEventListener('change', updatePreview); }
</script>
</body>
</html>
