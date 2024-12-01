let TrackingHooks = {
    mounted() {
        this.startTime = Date.now()
        this.isVisible = true
        this.lastUpdate = this.startTime

        document.addEventListener("visibilitychange", () => {
            if (document.hidden) {
                this.isVisible = false
                this.updateEngagementTime()
            } else {
                this.isVisible = true
                this.lastUpdate = Date.now()
            }
        })

        // Update engagement time periodically while page is visible
        this.timer = setInterval(() => {
                if (this.isVisible) {
                    this.updateEngagementTime()
                }
            }, 5000) // Update every 5 seconds
    },

    destroyed() {
        if (this.timer) {
            clearInterval(this.timer)
        }
        this.updateEngagementTime()
    },

    updateEngagementTime() {
        if (this.isVisible) {
            const now = Date.now()
            const additionalTime = Math.floor((now - this.lastUpdate) / 1000)
            this.lastUpdate = now

            this.pushEvent("update_engagement_time", { time: additionalTime })
        }
    }
}

export default TrackingHooks