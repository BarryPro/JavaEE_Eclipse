package com.belong.model;

public class VideoUrlConfig {
    private String videoHref;

    private String videoTitle;

    private String videoRating;

    private String videoImg;

    private String opTime;

    public String getVideoHref() {
        return videoHref;
    }

    public void setVideoHref(String videoHref) {
        this.videoHref = videoHref == null ? null : videoHref.trim();
    }

    public String getVideoTitle() {
        return videoTitle;
    }

    public void setVideoTitle(String videoTitle) {
        this.videoTitle = videoTitle == null ? null : videoTitle.trim();
    }

    public String getVideoRating() {
        return videoRating;
    }

    public void setVideoRating(String videoRating) {
        this.videoRating = videoRating == null ? null : videoRating.trim();
    }

    public String getVideoImg() {
        return videoImg;
    }

    public void setVideoImg(String videoImg) {
        this.videoImg = videoImg == null ? null : videoImg.trim();
    }

    public String getOpTime() {
        return opTime;
    }

    public void setOpTime(String opTime) {
        this.opTime = opTime == null ? null : opTime.trim();
    }
}
