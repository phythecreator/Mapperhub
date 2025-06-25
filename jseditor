// editor.js

const maps = [
  "world.svg",
  "europe.svg",
  "africa.svg",
  "south_america.svg",
  "north_america.svg",
  "central_america.svg",
  "asia.svg",
  "oceania.svg"
];

const freeColors = [
  "#1f78b4", "#33a02c", "#e31a1c", "#ff7f00", "#6a3d9a",
  "#a6cee3", "#b2df8a", "#fb9a99", "#fdbf6f", "#cab2d6",
  "#ffff99", "#8dd3c7", "#ffffb3", "#bebada", "#fb8072",
  "#80b1d3", "#fdb462", "#b3de69", "#fccde5", "#d9d9d9",
  "#bc80bd", "#ccebc5", "#ffed6f"
];

const premiumColors = [
  "#b15928", "#e41a1c", "#377eb8", "#4daf4a", "#984ea3",
  "#ff7f00", "#ffff33"
];

const basicEmojis = [
  "assets/emojis/basic/happy.png",
  "assets/emojis/basic/sad.png",
  "assets/emojis/basic/neutral.png",
  "assets/emojis/basic/very_happy.png"
];

const premiumEmojis = [
  "assets/emojis/premium/angry.png",
  "assets/emojis/premium/shocked.png",
  "assets/emojis/premium/laughing.png"
];

let points = parseInt(localStorage.getItem("points") || "0");
const userEmail = localStorage.getItem("userEmail") || null;
let premiumUnlocked = localStorage.getItem("premium") === "true";

const mapObj = document.getElementById("map");
const mapSelect = document.getElementById("mapSelect");
const paletteContainer = document.getElementById("palette");
const emojiContainer = document.getElementById("emojiContainer");
const pointsDisplay = document.getElementById("pointsDisplay");

let svgDoc = null;
let countries = [];
const selectedCountries = new Set();

function updatePointsDisplay() {
  pointsDisplay.textContent = `Points: ${points} / 170`;
}

function savePoints() {
  localStorage.setItem("points", points);
}

function addPoints(amount, key) {
  if (key && localStorage.getItem(key)) return; // already got points for this mission
  points += amount;
  savePoints();
  updatePointsDisplay();
  if (key) localStorage.setItem(key, "done");
  checkPremium();
}

function checkPremium() {
  if (points >= 170 && !premiumUnlocked) {
    premiumUnlocked = true;
    localStorage.setItem("premium", "true");
    alert("🎉 Congratulations! Premium unlocked.");
    showPalette();
    showEmojis();
  }
}

function loadMap(mapName) {
  mapObj.setAttribute("data", `assets/maps/${mapName}`);
  mapObj.addEventListener("load", () => {
    svgDoc = mapObj.contentDocument;
    countries = svgDoc.querySelectorAll("path, polygon, rect");
    countries.forEach(c => {
      c.style.cursor = "pointer";
      c.style.stroke = "#000";
      c.style.strokeWidth = "1";
      c.addEventListener("click", e => {
        if (e.shiftKey) {
          toggleCountrySelection(c);
        } else {
          clearSelection();
          selectCountry(c);
        }
      });
    });
  }, { once: true });
}

function clearSelection() {
  selectedCountries.forEach(c => {
    c.style.strokeWidth = "1";
    c.style.stroke = "#000";
  });
  selectedCountries.clear();
}

function selectCountry(country) {
  selectedCountries.add(country);
  country.style.strokeWidth = "3";
  country.style.stroke = "#ff0000";
}

function toggleCountrySelection(country) {
  if (selectedCountries.has(country)) {
    selectedCountries.delete(country);
    country.style.strokeWidth = "1";
    country.style.stroke = "#000";
  } else {
    selectedCountries.add(country);
    country.style.strokeWidth = "3";
    country.style.stroke = "#ff0000";
  }
}

function applyColor(color) {
  if (selectedCountries.size === 0) return alert("Select at least one country!");
  selectedCountries.forEach(c => {
    c.setAttribute("fill", color);
  });
}

function showPalette() {
  paletteContainer.innerHTML = "";
  const colors = premiumUnlocked ? freeColors.concat(premiumColors) : freeColors;
  colors.forEach(c => {
    const btn = document.createElement("button");
    btn.style.backgroundColor = c;
    btn.className = "w-8 h-8 m-1 rounded border border-gray-700";
    btn.title = c;
    btn.addEventListener("click", () => {
      applyColor(c);
    });
    paletteContainer.appendChild(btn);
  });
}

function insertEmoji(url) {
  if (!svgDoc) return;
  if (selectedCountries.size === 0) return alert("Select at least one country!");
  selectedCountries.forEach(c => {
    const bbox = c.getBBox();
    const img = svgDoc.createElementNS("http://www.w3.org/2000/svg", "image");
    img.setAttributeNS(null, "href", url);
    img.setAttribute("width", 20);
    img.setAttribute("height", 20);
    img.setAttribute("x", bbox.x + bbox.width / 2 - 10);
    img.setAttribute("y", bbox.y + bbox.height / 2 - 10);
    svgDoc.documentElement.appendChild(img);
  });
}

function showEmojis() {
  emojiContainer.innerHTML = "";
  basicEmojis.forEach(url => {
    const img = document.createElement("img");
    img.src = url;
    img.className = "emoji-btn";
    img.title = "Basic emoji";
    img.onclick = () => insertEmoji(url);
    emojiContainer.appendChild(img);
  });
  if (premiumUnlocked) {
    premiumEmojis.forEach(url => {
      const img = document.createElement("img");
      img.src = url;
      img.className = "emoji-btn premium-emoji";
      img.title = "Premium emoji";
      img.onclick = () => insertEmoji(url);
      emojiContainer.appendChild(img);
    });
  }
}

// Missões simuladas (podes ligar a botões e eventos)
function completeMissionFollow() {
  addPoints(70, "followInstagram");
  alert("You earned 70 points for following @tugamapper!");
}

function completeMissionCreateMap() {
  addPoints(20, "createdMap");
  alert("You earned 20 points for creating a map!");
}

function completeMissionDailyReward() {
  const today = new Date().toISOString().slice(0,10);
  if(localStorage.getItem("dailyCheck") === today) {
    alert("Daily reward already claimed.");
    return;
  }
  addPoints(40, "dailyCheck");
  localStorage.setItem("dailyCheck", today);
  alert("Daily reward: +40 points!");
}

function exportMap() {
  alert("Export simulated: you earned 10 points!");
  addPoints(10);
  // Aqui podes implementar export real via canvas/svg2png etc
}

document.addEventListener("DOMContentLoaded", () => {
  updatePointsDisplay();
  showPalette();
  showEmojis();
  loadMap("world.svg");

  mapSelect.innerHTML = "";
  maps.forEach(m => {
    const opt = document.createElement("option");
    opt.value = m;
    opt.textContent = m.replace(".svg", "").replace(/_/g, " ");
    mapSelect.appendChild(opt);
  });
  mapSelect.value = "world.svg";
  mapSelect.addEventListener("change", e => {
    clearSelection();
    loadMap(e.target.value);
  });

  // Liga botões de missões e export (exemplo, os botões têm que existir no HTML)
  document.getElementById("btnFollow").addEventListener("click", completeMissionFollow);
  document.getElementById("btnCreateMap").addEventListener("click", completeMissionCreateMap);
  document.getElementById("btnDailyReward").addEventListener("click", completeMissionDailyReward);
  document.getElementById("btnExport").addEventListener("click", exportMap);
});



