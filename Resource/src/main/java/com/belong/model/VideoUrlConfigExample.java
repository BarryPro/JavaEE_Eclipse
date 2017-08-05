package com.belong.model;

import java.util.ArrayList;
import java.util.List;

public class VideoUrlConfigExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public VideoUrlConfigExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    public String getOrderByClause() {
        return orderByClause;
    }

    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    public boolean isDistinct() {
        return distinct;
    }

    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andVideoHrefIsNull() {
            addCriterion("VIDEO_HREF is null");
            return (Criteria) this;
        }

        public Criteria andVideoHrefIsNotNull() {
            addCriterion("VIDEO_HREF is not null");
            return (Criteria) this;
        }

        public Criteria andVideoHrefEqualTo(String value) {
            addCriterion("VIDEO_HREF =", value, "videoHref");
            return (Criteria) this;
        }

        public Criteria andVideoHrefNotEqualTo(String value) {
            addCriterion("VIDEO_HREF <>", value, "videoHref");
            return (Criteria) this;
        }

        public Criteria andVideoHrefGreaterThan(String value) {
            addCriterion("VIDEO_HREF >", value, "videoHref");
            return (Criteria) this;
        }

        public Criteria andVideoHrefGreaterThanOrEqualTo(String value) {
            addCriterion("VIDEO_HREF >=", value, "videoHref");
            return (Criteria) this;
        }

        public Criteria andVideoHrefLessThan(String value) {
            addCriterion("VIDEO_HREF <", value, "videoHref");
            return (Criteria) this;
        }

        public Criteria andVideoHrefLessThanOrEqualTo(String value) {
            addCriterion("VIDEO_HREF <=", value, "videoHref");
            return (Criteria) this;
        }

        public Criteria andVideoHrefLike(String value) {
            addCriterion("VIDEO_HREF like", value, "videoHref");
            return (Criteria) this;
        }

        public Criteria andVideoHrefNotLike(String value) {
            addCriterion("VIDEO_HREF not like", value, "videoHref");
            return (Criteria) this;
        }

        public Criteria andVideoHrefIn(List<String> values) {
            addCriterion("VIDEO_HREF in", values, "videoHref");
            return (Criteria) this;
        }

        public Criteria andVideoHrefNotIn(List<String> values) {
            addCriterion("VIDEO_HREF not in", values, "videoHref");
            return (Criteria) this;
        }

        public Criteria andVideoHrefBetween(String value1, String value2) {
            addCriterion("VIDEO_HREF between", value1, value2, "videoHref");
            return (Criteria) this;
        }

        public Criteria andVideoHrefNotBetween(String value1, String value2) {
            addCriterion("VIDEO_HREF not between", value1, value2, "videoHref");
            return (Criteria) this;
        }

        public Criteria andVideoTitleIsNull() {
            addCriterion("VIDEO_TITLE is null");
            return (Criteria) this;
        }

        public Criteria andVideoTitleIsNotNull() {
            addCriterion("VIDEO_TITLE is not null");
            return (Criteria) this;
        }

        public Criteria andVideoTitleEqualTo(String value) {
            addCriterion("VIDEO_TITLE =", value, "videoTitle");
            return (Criteria) this;
        }

        public Criteria andVideoTitleNotEqualTo(String value) {
            addCriterion("VIDEO_TITLE <>", value, "videoTitle");
            return (Criteria) this;
        }

        public Criteria andVideoTitleGreaterThan(String value) {
            addCriterion("VIDEO_TITLE >", value, "videoTitle");
            return (Criteria) this;
        }

        public Criteria andVideoTitleGreaterThanOrEqualTo(String value) {
            addCriterion("VIDEO_TITLE >=", value, "videoTitle");
            return (Criteria) this;
        }

        public Criteria andVideoTitleLessThan(String value) {
            addCriterion("VIDEO_TITLE <", value, "videoTitle");
            return (Criteria) this;
        }

        public Criteria andVideoTitleLessThanOrEqualTo(String value) {
            addCriterion("VIDEO_TITLE <=", value, "videoTitle");
            return (Criteria) this;
        }

        public Criteria andVideoTitleLike(String value) {
            addCriterion("VIDEO_TITLE like", value, "videoTitle");
            return (Criteria) this;
        }

        public Criteria andVideoTitleNotLike(String value) {
            addCriterion("VIDEO_TITLE not like", value, "videoTitle");
            return (Criteria) this;
        }

        public Criteria andVideoTitleIn(List<String> values) {
            addCriterion("VIDEO_TITLE in", values, "videoTitle");
            return (Criteria) this;
        }

        public Criteria andVideoTitleNotIn(List<String> values) {
            addCriterion("VIDEO_TITLE not in", values, "videoTitle");
            return (Criteria) this;
        }

        public Criteria andVideoTitleBetween(String value1, String value2) {
            addCriterion("VIDEO_TITLE between", value1, value2, "videoTitle");
            return (Criteria) this;
        }

        public Criteria andVideoTitleNotBetween(String value1, String value2) {
            addCriterion("VIDEO_TITLE not between", value1, value2, "videoTitle");
            return (Criteria) this;
        }

        public Criteria andVideoRatinhIsNull() {
            addCriterion("VIDEO_RATINH is null");
            return (Criteria) this;
        }

        public Criteria andVideoRatinhIsNotNull() {
            addCriterion("VIDEO_RATINH is not null");
            return (Criteria) this;
        }

        public Criteria andVideoRatinhEqualTo(String value) {
            addCriterion("VIDEO_RATINH =", value, "videoRating");
            return (Criteria) this;
        }

        public Criteria andVideoRatinhNotEqualTo(String value) {
            addCriterion("VIDEO_RATINH <>", value, "videoRating");
            return (Criteria) this;
        }

        public Criteria andVideoRatinhGreaterThan(String value) {
            addCriterion("VIDEO_RATINH >", value, "videoRating");
            return (Criteria) this;
        }

        public Criteria andVideoRatinhGreaterThanOrEqualTo(String value) {
            addCriterion("VIDEO_RATINH >=", value, "videoRating");
            return (Criteria) this;
        }

        public Criteria andVideoRatinhLessThan(String value) {
            addCriterion("VIDEO_RATINH <", value, "videoRating");
            return (Criteria) this;
        }

        public Criteria andVideoRatinhLessThanOrEqualTo(String value) {
            addCriterion("VIDEO_RATINH <=", value, "videoRating");
            return (Criteria) this;
        }

        public Criteria andVideoRatinhLike(String value) {
            addCriterion("VIDEO_RATINH like", value, "videoRating");
            return (Criteria) this;
        }

        public Criteria andVideoRatinhNotLike(String value) {
            addCriterion("VIDEO_RATINH not like", value, "videoRating");
            return (Criteria) this;
        }

        public Criteria andVideoRatinhIn(List<String> values) {
            addCriterion("VIDEO_RATINH in", values, "videoRating");
            return (Criteria) this;
        }

        public Criteria andVideoRatinhNotIn(List<String> values) {
            addCriterion("VIDEO_RATINH not in", values, "videoRating");
            return (Criteria) this;
        }

        public Criteria andVideoRatinhBetween(String value1, String value2) {
            addCriterion("VIDEO_RATINH between", value1, value2, "videoRating");
            return (Criteria) this;
        }

        public Criteria andVideoRatinhNotBetween(String value1, String value2) {
            addCriterion("VIDEO_RATINH not between", value1, value2, "videoRating");
            return (Criteria) this;
        }

        public Criteria andVideoImgIsNull() {
            addCriterion("VIDEO_IMG is null");
            return (Criteria) this;
        }

        public Criteria andVideoImgIsNotNull() {
            addCriterion("VIDEO_IMG is not null");
            return (Criteria) this;
        }

        public Criteria andVideoImgEqualTo(String value) {
            addCriterion("VIDEO_IMG =", value, "videoImg");
            return (Criteria) this;
        }

        public Criteria andVideoImgNotEqualTo(String value) {
            addCriterion("VIDEO_IMG <>", value, "videoImg");
            return (Criteria) this;
        }

        public Criteria andVideoImgGreaterThan(String value) {
            addCriterion("VIDEO_IMG >", value, "videoImg");
            return (Criteria) this;
        }

        public Criteria andVideoImgGreaterThanOrEqualTo(String value) {
            addCriterion("VIDEO_IMG >=", value, "videoImg");
            return (Criteria) this;
        }

        public Criteria andVideoImgLessThan(String value) {
            addCriterion("VIDEO_IMG <", value, "videoImg");
            return (Criteria) this;
        }

        public Criteria andVideoImgLessThanOrEqualTo(String value) {
            addCriterion("VIDEO_IMG <=", value, "videoImg");
            return (Criteria) this;
        }

        public Criteria andVideoImgLike(String value) {
            addCriterion("VIDEO_IMG like", value, "videoImg");
            return (Criteria) this;
        }

        public Criteria andVideoImgNotLike(String value) {
            addCriterion("VIDEO_IMG not like", value, "videoImg");
            return (Criteria) this;
        }

        public Criteria andVideoImgIn(List<String> values) {
            addCriterion("VIDEO_IMG in", values, "videoImg");
            return (Criteria) this;
        }

        public Criteria andVideoImgNotIn(List<String> values) {
            addCriterion("VIDEO_IMG not in", values, "videoImg");
            return (Criteria) this;
        }

        public Criteria andVideoImgBetween(String value1, String value2) {
            addCriterion("VIDEO_IMG between", value1, value2, "videoImg");
            return (Criteria) this;
        }

        public Criteria andVideoImgNotBetween(String value1, String value2) {
            addCriterion("VIDEO_IMG not between", value1, value2, "videoImg");
            return (Criteria) this;
        }

        public Criteria andOpTimeIsNull() {
            addCriterion("OP_TIME is null");
            return (Criteria) this;
        }

        public Criteria andOpTimeIsNotNull() {
            addCriterion("OP_TIME is not null");
            return (Criteria) this;
        }

        public Criteria andOpTimeEqualTo(String value) {
            addCriterion("OP_TIME =", value, "opTime");
            return (Criteria) this;
        }

        public Criteria andOpTimeNotEqualTo(String value) {
            addCriterion("OP_TIME <>", value, "opTime");
            return (Criteria) this;
        }

        public Criteria andOpTimeGreaterThan(String value) {
            addCriterion("OP_TIME >", value, "opTime");
            return (Criteria) this;
        }

        public Criteria andOpTimeGreaterThanOrEqualTo(String value) {
            addCriterion("OP_TIME >=", value, "opTime");
            return (Criteria) this;
        }

        public Criteria andOpTimeLessThan(String value) {
            addCriterion("OP_TIME <", value, "opTime");
            return (Criteria) this;
        }

        public Criteria andOpTimeLessThanOrEqualTo(String value) {
            addCriterion("OP_TIME <=", value, "opTime");
            return (Criteria) this;
        }

        public Criteria andOpTimeLike(String value) {
            addCriterion("OP_TIME like", value, "opTime");
            return (Criteria) this;
        }

        public Criteria andOpTimeNotLike(String value) {
            addCriterion("OP_TIME not like", value, "opTime");
            return (Criteria) this;
        }

        public Criteria andOpTimeIn(List<String> values) {
            addCriterion("OP_TIME in", values, "opTime");
            return (Criteria) this;
        }

        public Criteria andOpTimeNotIn(List<String> values) {
            addCriterion("OP_TIME not in", values, "opTime");
            return (Criteria) this;
        }

        public Criteria andOpTimeBetween(String value1, String value2) {
            addCriterion("OP_TIME between", value1, value2, "opTime");
            return (Criteria) this;
        }

        public Criteria andOpTimeNotBetween(String value1, String value2) {
            addCriterion("OP_TIME not between", value1, value2, "opTime");
            return (Criteria) this;
        }
    }

    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }

    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}
