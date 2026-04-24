<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>Edit Room – Roomie Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
        :root{--bg:#060a12;--surface:rgba(255,255,255,0.04);--surface2:rgba(255,255,255,0.07);--gold:#c9a84c;--gold-light:#e4c470;--text:#e2e8f0;--text-muted:#8ba3c2;--border:rgba(201,168,76,0.12);--radius:20px;--nav-height:70px;--shadow:0 8px 32px rgba(0,0,0,0.5);--glass-bg:rgba(255,255,255,0.04);--glass-border:rgba(255,255,255,0.08);--glass-blur:blur(24px);}
        [data-theme="light"]{--bg:#f0f4f8;--surface:rgba(255,255,255,0.7);--surface2:rgba(255,255,255,0.85);--text:#1e293b;--text-muted:#4b6080;--border:rgba(30,58,95,0.1);--shadow:0 8px 32px rgba(0,0,0,0.08);--glass-bg:rgba(255,255,255,0.5);--glass-border:rgba(30,58,95,0.1);--glass-blur:blur(20px);}
        [data-theme="light"] input,[data-theme="light"] select,[data-theme="light"] textarea{background:#f0f4f8;}
        body{font-family:'Plus Jakarta Sans',sans-serif;background:var(--bg);color:var(--text);padding-top:var(--nav-height);overflow-x:hidden;transition:background .5s,color .5s;}
        .container{max-width:700px;margin:0 auto;padding:3rem 1.5rem;}
        .back-link{color:var(--gold);text-decoration:none;font-size:.87rem;display:inline-flex;align-items:center;gap:.4rem;margin-bottom:2rem;animation:fadeUp .6s ease both;}
        .page-title{font-family:'Outfit',sans-serif;font-size:1.8rem;margin-bottom:.4rem;animation:fadeUp .7s ease both;}
        .room-id-badge{font-size:.75rem;color:var(--text-muted);margin-bottom:2rem;display:block;animation:fadeUp .7s .05s ease both;}
        .form-card{background:var(--glass-bg);backdrop-filter:var(--glass-blur);border:1px solid var(--glass-border);border-radius:var(--radius);padding:2.5rem;box-shadow:var(--shadow);position:relative;overflow:hidden;animation:fadeUp .8s .1s ease both;}
        .form-card::before{content:'';position:absolute;top:0;left:0;right:0;height:2px;background:linear-gradient(90deg,transparent,var(--gold),transparent);}
        .form-row{display:grid;grid-template-columns:1fr 1fr;gap:1.2rem;}
        @media(max-width:600px){.form-row{grid-template-columns:1fr;}}
        .form-group{margin-bottom:1.3rem;}
        label{display:block;font-size:.8rem;color:var(--text-muted);margin-bottom:.5rem;font-weight:500;}
        input,select,textarea{width:100%;padding:.8rem 1rem;border-radius:12px;border:1.5px solid var(--border);background:rgba(8,14,26,.5);color:var(--text);font-size:.92rem;transition:border-color .3s,box-shadow .3s;font-family:'Plus Jakarta Sans',sans-serif;}
        textarea{resize:vertical;min-height:80px;}
        input:focus,select:focus,textarea:focus{outline:none;border-color:var(--gold);box-shadow:0 0 0 3px rgba(201,168,76,.12);}
        .hint{font-size:.74rem;color:var(--text-muted);margin-top:.4rem;}
        .current-image-wrap{margin-bottom:1rem;}
        .current-img{width:100%;max-height:200px;object-fit:cover;border-radius:14px;border:1px solid var(--glass-border);}
        .current-img-label{font-size:.74rem;color:var(--text-muted);margin-top:.35rem;}
        .upload-area{border:2px dashed var(--border);border-radius:14px;padding:1.2rem;text-align:center;cursor:pointer;transition:all .3s;position:relative;}
        .upload-area:hover{border-color:var(--gold);background:rgba(201,168,76,.04);}
        .upload-area input[type=file]{position:absolute;inset:0;opacity:0;cursor:pointer;width:100%;height:100%;}
        .upload-icon{font-size:1.6rem;margin-bottom:.3rem;opacity:.5;}
        .upload-label{font-size:.82rem;color:var(--text-muted);}
        .upload-label span{color:var(--gold);font-weight:600;}
        #imagePreview{display:none;margin-top:.8rem;width:100%;max-height:170px;object-fit:cover;border-radius:12px;border:1px solid var(--glass-border);}
        #selectedFileName{font-size:.75rem;color:var(--gold);margin-top:.5rem;display:none;}
        .status-row{display:flex;gap:.6rem;flex-wrap:wrap;}
        .status-pill input[type=radio]{display:none;}
        .status-pill label{display:inline-block;padding:.35rem 1rem;border-radius:20px;font-size:.8rem;font-weight:600;cursor:pointer;border:1.5px solid transparent;transition:all .2s;}
        .status-pill.available label{border-color:rgba(74,222,128,.35);color:#4ade80;}
        .status-pill.occupied label{border-color:rgba(248,113,113,.35);color:#f87171;}
        .status-pill.maintenance label{border-color:rgba(251,191,36,.35);color:#fbbf24;}
        .status-pill input[type=radio]:checked + label{background:rgba(201,168,76,.12);border-color:var(--gold);color:var(--gold);}
        .btn-row{display:flex;gap:1rem;align-items:center;flex-wrap:wrap;margin-top:.5rem;}
        .btn-submit{padding:.9rem 2.5rem;background:linear-gradient(135deg,var(--gold),var(--gold-light));color:#0a0e18;border:none;border-radius:25px;font-size:1rem;font-weight:700;cursor:pointer;transition:all .4s cubic-bezier(.23,1,.32,1);box-shadow:0 4px 25px rgba(201,168,76,.35);}
        .btn-submit:hover{transform:translateY(-3px) scale(1.02);box-shadow:0 8px 40px rgba(201,168,76,.5);}
        .btn-cancel{color:var(--text-muted);text-decoration:none;font-size:.88rem;transition:color .2s;}
        .btn-cancel:hover{color:var(--gold);}
        @keyframes fadeUp{from{opacity:0;transform:translateY(35px)}to{opacity:1;transform:translateY(0)}}
    </style>
</head>
<body>
<jsp:include page="../navbar.jsp"/>
<div class="container">
    <a href="/room/manage" class="back-link">← Manage Rooms</a>
    <h1 class="page-title">Edit Room</h1>
    <span class="room-id-badge">ID: ${room.roomId} &nbsp;·&nbsp; Room ${room.roomNumber}</span>
    <div class="form-card">
        <form action="/room/edit/${room.roomId}" method="post" enctype="multipart/form-data">
            <div class="form-row">
                <div class="form-group"><label for="roomNumber">Room Number</label><input type="text" id="roomNumber" name="roomNumber" value="${room.roomNumber}" required></div>
                <div class="form-group"><label for="type">Room Type</label><select id="type" name="type" required><option value="Standard" ${room.type == 'Standard' ? 'selected' : ''}>Coastal (Standard)</option><option value="Deluxe" ${room.type == 'Deluxe' ? 'selected' : ''}>Hill Country (Deluxe)</option><option value="Suite" ${room.type == 'Suite' ? 'selected' : ''}>Jungle (Suite)</option></select></div>
            </div>
            <div class="form-row">
                <div class="form-group"><label for="pricePerNight">Price Per Night (LKR)</label><input type="number" id="pricePerNight" name="pricePerNight" value="${room.pricePerNight}" required min="1000"></div>
                <div class="form-group"><label for="capacity">Capacity (Guests)</label><input type="number" id="capacity" name="capacity" value="${room.capacity}" required min="1" max="10"></div>
            </div>
            <div class="form-group"><label for="description">View Description</label><input type="text" id="description" name="description" value="${room.description}" required></div>
            <div class="form-group"><label for="amenities">Amenities</label><input type="text" id="amenities" name="amenities" value="${room.amenitiesPipe}" required><div class="hint">Separate with | (pipe) character. E.g. WiFi|AC|TV|Mini Bar</div></div>
            <div class="form-group"><label>Status</label>
                <div class="status-row">
                    <div class="status-pill available"><input type="radio" id="s-available" name="status" value="AVAILABLE" ${room.status.name() == 'AVAILABLE' ? 'checked' : ''}><label for="s-available">Available</label></div>
                    <div class="status-pill occupied"><input type="radio" id="s-occupied" name="status" value="OCCUPIED" ${room.status.name() == 'OCCUPIED' ? 'checked' : ''}><label for="s-occupied">Occupied</label></div>
                    <div class="status-pill maintenance"><input type="radio" id="s-maintenance" name="status" value="MAINTENANCE" ${room.status.name() == 'MAINTENANCE' ? 'checked' : ''}><label for="s-maintenance">Maintenance</label></div>
                </div>
            </div>
            <div class="form-group"><label>Room Image</label>
                <div class="current-image-wrap"><img src="/images/${room.imageFile}" class="current-img" alt="Current room image"><div class="current-img-label">Current image — leave blank to keep it</div></div>
                <div class="upload-area" id="uploadArea"><input type="file" id="image" name="image" accept="image/*"><div class="upload-icon">🖼️</div><div class="upload-label">Drop a new image here or <span>browse</span></div><div class="hint">JPG, PNG, WEBP · Max 10 MB · Leave empty to keep current</div><img id="imagePreview" src="" alt="New image preview"><div id="selectedFileName"></div></div>
            </div>
            <div class="btn-row"><button type="submit" class="btn-submit">Save Changes →</button><a href="/room/manage" class="btn-cancel">Cancel</a></div>
        </form>
    </div>
</div>
<script>
(function(){var t=localStorage.getItem('roomie-theme')||'dark';document.documentElement.setAttribute('data-theme',t);})();
const fi=document.getElementById('image'),pv=document.getElementById('imagePreview'),nm=document.getElementById('selectedFileName');
fi.addEventListener('change',function(){const f=this.files[0];if(!f)return;nm.textContent='✓ '+f.name;nm.style.display='block';const r=new FileReader();r.onload=e=>{pv.src=e.target.result;pv.style.display='block';};r.readAsDataURL(f);});
</script>
</body>
</html>
