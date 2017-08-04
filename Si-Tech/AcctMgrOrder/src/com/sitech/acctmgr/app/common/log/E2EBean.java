package com.sitech.acctmgr.app.common.log;

/**
 * Created by hp on 2015/9/8.
 */
public class E2EBean
{
    private String traceId;
    private String callId;
    private String parentCallId;
    private String spanId;
    private String spanidName;
    private String linkType;
    private String regionCode;
    private String functionName;
    private String startTime;
    private String endTime;
    private String hostIp;
    private String port;
    private String clientIp;
    private String objectType;
    private String objectValue;
    private String userId;
    private String bhCode;
    private String opCode;
    private String resultCode;
    private String ResultInfo;
    private String inParams;
    private String outParams;

    public E2EBean()
    {
        this.traceId = "";

        this.callId = "";
        this.parentCallId = "";
        this.spanId = "";
        this.spanidName = "";
        this.linkType = "";
        this.regionCode = "";
        this.functionName = "";
        this.startTime = "";
        this.endTime = "";
        this.hostIp = "";
        this.port = "";
        this.clientIp = "";
        this.objectType = "";
        this.objectValue = "";
        this.userId = "";
        this.bhCode = "";
        this.opCode = "";
        this.resultCode = "";
        this.ResultInfo = "";
        this.inParams = "";
        this.outParams = "";
    }

    public String getSpanId()
    {
        return this.spanId; }

    public void setSpanId(String spanId) {
        this.spanId = spanId; }

    public String getLinkType() {
        return this.linkType; }

    public void setLinkType(String linkType) {
        this.linkType = linkType; }

    public String getRegionCode() {
        return this.regionCode; }

    public void setRegionCode(String regionCode) {
        this.regionCode = regionCode; }

    public String getFunctionName() {
        return this.functionName; }

    public void setFunctionName(String functionName) {
        this.functionName = functionName; }

    public String getClientIp() {
        return this.clientIp; }

    public void setClientIp(String clientIp) {
        this.clientIp = clientIp; }

    public String getObjectType() {
        return this.objectType; }

    public void setObjectType(String objectType) {
        this.objectType = objectType; }

    public String getObjectValue() {
        return this.objectValue; }

    public void setObjectValue(String objectValue) {
        this.objectValue = objectValue; }

    public String getUserId() {
        return this.userId; }

    public void setUserId(String userId) {
        this.userId = userId; }

    public String getBhCode() {
        return this.bhCode; }

    public void setBhCode(String bhCode) {
        this.bhCode = bhCode; }

    public String getOpCode() {
        return this.opCode; }

    public void setOpCode(String opCode) {
        this.opCode = opCode; }

    public String getInParams() {
        return this.inParams; }

    public void setInParams(String inParams) {
        this.inParams = inParams; }

    public String getOutParams() {
        return this.outParams; }

    public void setOutParams(String outParams) {
        this.outParams = outParams;
    }

    public String getTraceId()
    {
        return this.traceId; }

    public void setTraceId(String traceId) {
        this.traceId = traceId; }

    public String getCallId() {
        return this.callId; }

    public void setCallId(String callId) {
        this.callId = callId; }

    public String getParentCallId() {
        return this.parentCallId; }

    public void setParentCallId(String parentCallId) {
        this.parentCallId = parentCallId; }

    public String getSpanidName() {
        return this.spanidName; }

    public void setSpanidName(String spanidName) {
        this.spanidName = spanidName; }

    public String getStartTime() {
        return this.startTime; }

    public void setStartTime(String startTime) {
        this.startTime = startTime; }

    public String getEndTime() {
        return this.endTime; }

    public void setEndTime(String endTime) {
        this.endTime = endTime; }

    public String getHostIp() {
        return this.hostIp; }

    public void setHostIp(String hostIp) {
        this.hostIp = hostIp; }

    public String getPort() {
        return this.port; }

    public void setPort(String port) {
        this.port = port; }

    public String getResultCode() {
        return this.resultCode; }

    public void setResultCode(String resultCode) {
        this.resultCode = resultCode; }

    public String getResultInfo() {
        return this.ResultInfo; }

    public void setResultInfo(String resultInfo) {
        this.ResultInfo = resultInfo;
    }
}