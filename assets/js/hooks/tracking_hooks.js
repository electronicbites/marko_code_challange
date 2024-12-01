let TrackingHooks = {
  mounted() {
    this.startTime = Date.now();
    this.isVisible = true;
    this.lastUpdate = this.startTime;

    const self = this; // Store reference to correct 'this'

    document.addEventListener("visibilitychange", () => {
      if (document.hidden) {
        self.isVisible = false;
        self.updateEngagementTime();
      } else {
        self.isVisible = true;
        self.lastUpdate = Date.now();
      }
    });

    this.timer = setInterval(() => {
      if (self.isVisible) {
        self.updateEngagementTime();
      }
    }, 5000); // Changed to actual 5 seconds
  },

  destroyed() {
    if (this.timer) {
      clearInterval(this.timer);
    }
    this.updateEngagementTime();
  },

  updateEngagementTime() {
    if (this.isVisible) {
      const now = Date.now();
      const additionalTime = Math.floor((now - this.lastUpdate) / 1000);
      this.lastUpdate = now;

      this.pushEvent("update_engagement_time", { time: additionalTime });
    }
  },
};

export default TrackingHooks;
