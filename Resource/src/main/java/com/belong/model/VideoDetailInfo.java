package com.belong.model;

public class VideoDetailInfo {
    private String videoHref;

    private String videoPic;

    private String opTime;

    private byte[] videoInfo;

    public String getVideoHref() {
        return videoHref;
    }

    public void setVideoHref(String videoHref) {
        this.videoHref = videoHref == null ? null : videoHref.trim();
    }

    public String getVideoPic() {
        return videoPic;
    }

    public void setVideoPic(String videoPic) {
        this.videoPic = videoPic == null ? null : videoPic.trim();
    }

    public String getOpTime() {
        return opTime;
    }

    public void setOpTime(String opTime) {
        this.opTime = opTime == null ? null : opTime.trim();
    }

    public byte[] getVideoInfo() {
        return videoInfo;
    }

    public void setVideoInfo(byte[] videoInfo) {
        this.videoInfo = videoInfo;
    }
}