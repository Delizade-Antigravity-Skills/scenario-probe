# Scenario Probe Audit Design System & Component Contracts

Bu doküman, `scenario-probe` becerisinin HTML denetim raporlarında (`scenario-*.html`) kullanılan tasarım sistemi token'larını, biçimlendirme kurallarını ve bileşen sözleşmelerini (component contracts) tanımlar.

---

## 1. Tasarım Felsefesi ve Katı Kurallar

1. **Katı 3 Renkli Editoryal Palet:**
   - **Krem Beyaz (Canvas & Yüzeyler):** `#FAF8F5`
   - **Koyu Kömür / Dark Charcoal (Metin & Kontrast):** `#181716`
   - **Terracotta Kiremit (Tekil Vurgu & Aksan):** `#C85A32`
2. **Sıfır Inline Stil Kuralı (Zero Inline Styles):**
   - HTML çıktılarında `style="..."` özniteliği **kesinlikle yasaktır**. Tüm genişlikler, aralıklar, renkler ve geçişler saf CSS (`assets/audit.css`) tarafından yönetilir.
   - İlerleme çubukları yerel semantik `<progress class="dimension-progress" value="XX" max="100"></progress>` olarak kodlanır ve CSS pseudo-elementleri ile stillendirilir.
3. **Katı Token Tabanlı Tipografi ve Aralıklar:**
   - Ad-hoc piksel değerleri yasaktır; tüm boşluklar 4px geometrik ızgara ölçeğine (`--space-1` ila `--space-20`) ve tipografi hiyerarşisine dayanır.

---

## 2. Design Token Kayıt Defteri (`audit.css`)

### 2.1 Renk Token'ları

| Token Adı | Değer | Amaç / Kullanım |
|---|---|---|
| `--color-cream-100` (`--bg-canvas`) | `#FAF8F5` | Sayfa arka plan rengi |
| `--color-cream-50` (`--bg-surface`) | `#FFFFFF` | Kart ve tablo yüzeyleri |
| `--color-cream-200` (`--bg-surface-raised`) | `#F4F0EA` | Yükseltilmiş yüzeyler, tablo başlıkları, skor kutusu |
| `--color-cream-300` (`--border-subtle`) | `#E5E0D6` | İnce kart ve hücre sınırları |
| `--color-charcoal-900` (`--text-primary`) | `#181716` | Ana metin, başlıklar, güçlü kenarlıklar |
| `--color-charcoal-600` (`--text-muted`) | `#6B665F` | İkincil metin, etiketler |
| `--color-charcoal-400` (`--text-dim`) | `#9C968D` | Soluk detaylar, kesikli kenarlıklar |
| `--color-terracotta-500` (`--accent-base`) | `#C85A32` | Tekil vurgu rengi, butonlar, P0 rozeti, skor |
| `--color-terracotta-08` (`--accent-tint-subtle`)| `rgba(200, 90, 50, 0.08)` | Yüksek sürtünme arka planı, hafif vurgular |
| `--color-terracotta-18` (`--accent-tint-heavy`) | `rgba(200, 90, 50, 0.18)` | Engelleyici arka planı |
| `--color-terracotta-35` (`--border-accent`) | `rgba(200, 90, 50, 0.35)` | Vurgulu rozet ve uyarı sınırları |

### 2.2 Geometrik Aralık Ölçeği (4px Temelli)

- `--space-0-5`: `2px`
- `--space-0-75`: `3px`
- `--space-1`: `4px`
- `--space-1-5`: `6px`
- `--space-2`: `8px`
- `--space-2-5`: `10px`
- `--space-3`: `12px`
- `--space-3-5`: `14px`
- `--space-4`: `16px`
- `--space-4-5`: `18px`
- `--space-5`: `20px`
- `--space-6`: `24px`
- `--space-8`: `32px`
- `--space-10`: `40px`
- `--space-12`: `48px`
- `--space-14`: `56px`
- `--space-20`: `80px`

### 2.3 Tipografi Hiyerarşisi

- `--font-size-2xs`: `0.7rem` (10.5px) — Küçük rozetler (`.audit-nav-badge`, `.tier-badge`)
- `--font-size-xs`: `0.72rem` (10.8px) — Akış etiketleri (`.flow-trio-label`), durum rozetleri (`.status-badge`)
- `--font-size-sm`: `0.75rem` (11.25px) — Tablo başlıkları, çağrı etiketi
- `--font-size-compact`: `0.8rem` (12px) — Adım indeksi (`.flow-step-number`), skor alt etiketi
- `--font-size-meta`: `0.82rem` (12.3px) — İyileştirme açıklama metni
- `--font-size-sub`: `0.85rem` (12.75px) — Meta bilgiler, navigasyon linkleri, sütun açıklamaları
- `--font-size-item`: `0.88rem` (13.2px) — İyileştirme maddeleri
- `--font-size-body`: `0.9rem` (13.5px) — Tablo gövdesi, akış içerikleri, butonlar
- `--font-size-base`: `0.95rem` (14.25px) — Sütun başlıkları, marka, kademe başlıkları
- `--font-size-lead`: `1.05rem` (15.75px) — Adım başlıkları, niyet açıklaması
- `--font-size-lg`: `1.1rem` (16.5px) — Banner başlığı
- `--font-size-title`: `1.25rem` (18.75px) — Bölüm başlıkları
- `--font-size-hero`: `2.2rem` (33px) — Ana senaryo başlığı
- `--font-size-kpi`: `3.5rem` (52.5px) — Büyük skor metriği

---

## 3. Bileşen Sözleşmeleri (Component Contracts)

### C1: Sabit Üst Navigasyon Menüsü (`.audit-nav`)
```html
<nav class="audit-nav">
  <a href="#" class="audit-nav-brand">
    <span class="audit-nav-badge">Denetim</span>
    <span>Scenario Probe</span>
  </a>
  <ul class="audit-nav-links">
    <li><a href="#overview">Genel Bakış</a></li>
    <li><a href="#pillars">Temel Sütunlar</a></li>
    <li><a href="#flow">Görev Akışı</a></li>
    <li><a href="#journey">Yolculuk Matrisi</a></li>
    <li><a href="#scorecard">Skor Kartı</a></li>
    <li><a href="#remediation">İyileştirme Planı</a></li>
  </ul>
</nav>
```

### C2: Başlık Hero ve Niyet Çağrısı (`.audit-header`)
```html
<header id="overview" class="audit-header">
  <div class="audit-meta-row">
    <div class="audit-meta-item">Kapsam: <strong>[Kapsam]</strong></div>
    <div class="audit-meta-item">Persona: <strong>[Persona Tanımı]</strong></div>
    <div class="audit-meta-item">Tarih: <strong>YYYY-MM-DD</strong></div>
    <div class="audit-meta-item">Durum: <strong>[Özet Durum]</strong></div>
  </div>
  <h1 class="audit-title">[Senaryo Başlığı]</h1>
  <div class="audit-intent-callout">
    <span>Kullanıcı Girdisi ve Hedef Çıktı</span>
    [Auteur hedefi ve nihai çıktı özeti]
  </div>
</header>
```

### C3: Temel Alan Sütun Kartı (`.pillar-card`)
```html
<div class="pillar-card">
  <div class="pillar-title">1. Dünya ve Kanon Ontolojisi</div>
  <div class="pillar-desc">[Sistem kuralı ve mimari dayanak]</div>
</div>
```

### C4: Görev Akışı Adım Kartı (`.flow-step-card`)
Kart durumu `flow-step-supported`, `flow-step-friction`, `flow-step-blocker` veya `flow-step-gap` modifiyer sınıflarını alır.

```html
<div class="flow-step-card flow-step-friction">
  <div class="flow-card-header">
    <div class="flow-step-badge-group">
      <span class="flow-step-number">03</span>
      <span class="flow-step-title">Karakter Oluşturma</span>
    </div>
    <span class="status-badge status-friction">Yüksek Sürtünme</span>
  </div>
  <div class="flow-trio-grid">
    <div class="flow-trio-item">
      <span class="flow-trio-label">Ne Yapmaya Çalıştı?</span>
      <span class="flow-trio-content">Karakter model sayfası üretmek istedi.</span>
    </div>
    <div class="flow-trio-item">
      <span class="flow-trio-label">Nerede Yapmaya Çalıştı?</span>
      <span class="flow-trio-content"><code>/characters/new</code></span>
    </div>
    <div class="flow-trio-item trio-outcome">
      <span class="flow-trio-label">Ne Oldu?</span>
      <span class="flow-trio-content">Hazır etiket bulunmadığı için promptu elle yazdı.</span>
    </div>
  </div>
</div>
```

### C5: Durum Rozeti (`.status-badge`)
- `.status-supported`: Destekleniyor (Açık yükseltilmiş nötr)
- `.status-friction`: Yüksek Sürtünme (Terracotta arka plan ve sınır)
- `.status-blocker`: Kritik Engelleyici (Dolgun Terracotta zemin)
- `.status-gap`: Sistem Boşluğu (Kesikli nötr sınır)

### C6: Çok Boyutlu Sistem Skor Kartı (`.scorecard-container`)
Tamamen semantik HTML5 `<progress>` öğesi ile sıfır inline stil güvencesi.

```html
<div class="scorecard-container">
  <div class="scorecard-main">
    <div class="scorecard-value">%85</div>
    <div class="scorecard-label">Genel Hazırlık Skoru</div>
  </div>
  <div class="dimension-list">
    <div class="dimension-item">
      <div class="dimension-header">
        <span class="dimension-name">Yönetsel Rehberlik & Co-Pilot (%25)</span>
        <span class="dimension-score">%78</span>
      </div>
      <progress class="dimension-progress" value="78" max="100"></progress>
    </div>
  </div>
</div>
```

### C7: İyileştirme Planı ve Kademe Rozetleri (`.remediation-group`)
```html
<div class="remediation-group">
  <div class="remediation-tier-title">
    <span class="tier-badge tier-p1">P1</span>
    <span>Yüksek Sürtünme ve Rehberlik Boşlukları (2 Adet)</span>
  </div>
  <ul class="remediation-list">
    <li class="remediation-item">
      <span class="remediation-check">✦</span>
      <div class="remediation-content">
        <strong>Görev Başlığı</strong>
        <p>Açıklama ve yönetsel fayda metni.</p>
      </div>
    </li>
  </ul>
</div>
```

### C8: Eyleme Geçiş Banner'ı (`.handoff-banner`)
```html
<aside class="handoff-banner">
  <div class="handoff-text">
    <h4>P1 yönetsel sürtünme maddelerini çözmek için implementasyona başlayalım mı?</h4>
    <p>Yönetmen egemenliği: Yüksek etkili iyileştirme planı otonom uygulama için hazır.</p>
  </div>
  <a href="#remediation" class="handoff-button">Eylemleri Uygula</a>
</aside>
```
