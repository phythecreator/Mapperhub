document.addEventListener("DOMContentLoaded", () => {
  // Daily reward mission logic
  const dailyMissionKey = "mission_dailyReward";
  const dailyRewardPts = 40;

  function getTodayDate() {
    return new Date().toISOString().split("T")[0];
  }

  // Give daily points if not yet done today
  function dailyCheckIn() {
    if (!localStorage.getItem("userEmail")) return;
    const lastCheck = localStorage.getItem("lastCheckDate");
    const today = getTodayDate();
    if (lastCheck === today) {
      return; // Already claimed today
    }
    localStorage.setItem("lastCheckDate", today);
    if (localStorage.getItem(dailyMissionKey) !== "done") {
      localStorage.setItem(dailyMissionKey, "done");
      let pts = parseInt(localStorage.getItem("points")) || 0;
      pts += dailyRewardPts;
      localStorage.setItem("points", pts);
      alert("Daily reward: +40 points!");
      // Update missions and points display in index
      if(typeof window.markMissionDone === "function") {
        window.markMissionDone("dailyReward");
      }
    }
  }

  dailyCheckIn();

  // Other social missions (simulate Instagram follow etc)

  // Example: Simulate Instagram follow button on index.html (if you add it)
  // You can connect with real APIs or just simulate click events to award points
});
