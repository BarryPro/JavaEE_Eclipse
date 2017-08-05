package com.belong.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class VideoRecExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public VideoRecExample() {
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

        public Criteria andVideoSrcIsNull() {
            addCriterion("VIDEO_SRC is null");
            return (Criteria) this;
        }

        public Criteria andVideoSrcIsNotNull() {
            addCriterion("VIDEO_SRC is not null");
            return (Criteria) this;
        }

        public Criteria andVideoSrcEqualTo(String value) {
            addCriterion("VIDEO_SRC =", value, "videoSrc");
            return (Criteria) this;
        }

        public Criteria andVideoSrcNotEqualTo(String value) {
            addCriterion("VIDEO_SRC <>", value, "videoSrc");
            return (Criteria) this;
        }

        public Criteria andVideoSrcGreaterThan(String value) {
            addCriterion("VIDEO_SRC >", value, "videoSrc");
            return (Criteria) this;
        }

        public Criteria andVideoSrcGreaterThanOrEqualTo(String value) {
            addCriterion("VIDEO_SRC >=", value, "videoSrc");
            return (Criteria) this;
        }

        public Criteria andVideoSrcLessThan(String value) {
            addCriterion("VIDEO_SRC <", value, "videoSrc");
            return (Criteria) this;
        }

        public Criteria andVideoSrcLessThanOrEqualTo(String value) {
            addCriterion("VIDEO_SRC <=", value, "videoSrc");
            return (Criteria) this;
        }

        public Criteria andVideoSrcLike(String value) {
            addCriterion("VIDEO_SRC like", value, "videoSrc");
            return (Criteria) this;
        }

        public Criteria andVideoSrcNotLike(String value) {
            addCriterion("VIDEO_SRC not like", value, "videoSrc");
            return (Criteria) this;
        }

        public Criteria andVideoSrcIn(List<String> values) {
            addCriterion("VIDEO_SRC in", values, "videoSrc");
            return (Criteria) this;
        }

        public Criteria andVideoSrcNotIn(List<String> values) {
            addCriterion("VIDEO_SRC not in", values, "videoSrc");
            return (Criteria) this;
        }

        public Criteria andVideoSrcBetween(String value1, String value2) {
            addCriterion("VIDEO_SRC between", value1, value2, "videoSrc");
            return (Criteria) this;
        }

        public Criteria andVideoSrcNotBetween(String value1, String value2) {
            addCriterion("VIDEO_SRC not between", value1, value2, "videoSrc");
            return (Criteria) this;
        }

        public Criteria andVideoNameIsNull() {
            addCriterion("VIDEO_NAME is null");
            return (Criteria) this;
        }

        public Criteria andVideoNameIsNotNull() {
            addCriterion("VIDEO_NAME is not null");
            return (Criteria) this;
        }

        public Criteria andVideoNameEqualTo(String value) {
            addCriterion("VIDEO_NAME =", value, "videoName");
            return (Criteria) this;
        }

        public Criteria andVideoNameNotEqualTo(String value) {
            addCriterion("VIDEO_NAME <>", value, "videoName");
            return (Criteria) this;
        }

        public Criteria andVideoNameGreaterThan(String value) {
            addCriterion("VIDEO_NAME >", value, "videoName");
            return (Criteria) this;
        }

        public Criteria andVideoNameGreaterThanOrEqualTo(String value) {
            addCriterion("VIDEO_NAME >=", value, "videoName");
            return (Criteria) this;
        }

        public Criteria andVideoNameLessThan(String value) {
            addCriterion("VIDEO_NAME <", value, "videoName");
            return (Criteria) this;
        }

        public Criteria andVideoNameLessThanOrEqualTo(String value) {
            addCriterion("VIDEO_NAME <=", value, "videoName");
            return (Criteria) this;
        }

        public Criteria andVideoNameLike(String value) {
            addCriterion("VIDEO_NAME like", value, "videoName");
            return (Criteria) this;
        }

        public Criteria andVideoNameNotLike(String value) {
            addCriterion("VIDEO_NAME not like", value, "videoName");
            return (Criteria) this;
        }

        public Criteria andVideoNameIn(List<String> values) {
            addCriterion("VIDEO_NAME in", values, "videoName");
            return (Criteria) this;
        }

        public Criteria andVideoNameNotIn(List<String> values) {
            addCriterion("VIDEO_NAME not in", values, "videoName");
            return (Criteria) this;
        }

        public Criteria andVideoNameBetween(String value1, String value2) {
            addCriterion("VIDEO_NAME between", value1, value2, "videoName");
            return (Criteria) this;
        }

        public Criteria andVideoNameNotBetween(String value1, String value2) {
            addCriterion("VIDEO_NAME not between", value1, value2, "videoName");
            return (Criteria) this;
        }

        public Criteria andVideoPicIsNull() {
            addCriterion("VIDEO_PIC is null");
            return (Criteria) this;
        }

        public Criteria andVideoPicIsNotNull() {
            addCriterion("VIDEO_PIC is not null");
            return (Criteria) this;
        }

        public Criteria andVideoPicEqualTo(String value) {
            addCriterion("VIDEO_PIC =", value, "videoPic");
            return (Criteria) this;
        }

        public Criteria andVideoPicNotEqualTo(String value) {
            addCriterion("VIDEO_PIC <>", value, "videoPic");
            return (Criteria) this;
        }

        public Criteria andVideoPicGreaterThan(String value) {
            addCriterion("VIDEO_PIC >", value, "videoPic");
            return (Criteria) this;
        }

        public Criteria andVideoPicGreaterThanOrEqualTo(String value) {
            addCriterion("VIDEO_PIC >=", value, "videoPic");
            return (Criteria) this;
        }

        public Criteria andVideoPicLessThan(String value) {
            addCriterion("VIDEO_PIC <", value, "videoPic");
            return (Criteria) this;
        }

        public Criteria andVideoPicLessThanOrEqualTo(String value) {
            addCriterion("VIDEO_PIC <=", value, "videoPic");
            return (Criteria) this;
        }

        public Criteria andVideoPicLike(String value) {
            addCriterion("VIDEO_PIC like", value, "videoPic");
            return (Criteria) this;
        }

        public Criteria andVideoPicNotLike(String value) {
            addCriterion("VIDEO_PIC not like", value, "videoPic");
            return (Criteria) this;
        }

        public Criteria andVideoPicIn(List<String> values) {
            addCriterion("VIDEO_PIC in", values, "videoPic");
            return (Criteria) this;
        }

        public Criteria andVideoPicNotIn(List<String> values) {
            addCriterion("VIDEO_PIC not in", values, "videoPic");
            return (Criteria) this;
        }

        public Criteria andVideoPicBetween(String value1, String value2) {
            addCriterion("VIDEO_PIC between", value1, value2, "videoPic");
            return (Criteria) this;
        }

        public Criteria andVideoPicNotBetween(String value1, String value2) {
            addCriterion("VIDEO_PIC not between", value1, value2, "videoPic");
            return (Criteria) this;
        }

        public Criteria andVideoTypeIsNull() {
            addCriterion("VIDEO_TYPE is null");
            return (Criteria) this;
        }

        public Criteria andVideoTypeIsNotNull() {
            addCriterion("VIDEO_TYPE is not null");
            return (Criteria) this;
        }

        public Criteria andVideoTypeEqualTo(String value) {
            addCriterion("VIDEO_TYPE =", value, "videoType");
            return (Criteria) this;
        }

        public Criteria andVideoTypeNotEqualTo(String value) {
            addCriterion("VIDEO_TYPE <>", value, "videoType");
            return (Criteria) this;
        }

        public Criteria andVideoTypeGreaterThan(String value) {
            addCriterion("VIDEO_TYPE >", value, "videoType");
            return (Criteria) this;
        }

        public Criteria andVideoTypeGreaterThanOrEqualTo(String value) {
            addCriterion("VIDEO_TYPE >=", value, "videoType");
            return (Criteria) this;
        }

        public Criteria andVideoTypeLessThan(String value) {
            addCriterion("VIDEO_TYPE <", value, "videoType");
            return (Criteria) this;
        }

        public Criteria andVideoTypeLessThanOrEqualTo(String value) {
            addCriterion("VIDEO_TYPE <=", value, "videoType");
            return (Criteria) this;
        }

        public Criteria andVideoTypeLike(String value) {
            addCriterion("VIDEO_TYPE like", value, "videoType");
            return (Criteria) this;
        }

        public Criteria andVideoTypeNotLike(String value) {
            addCriterion("VIDEO_TYPE not like", value, "videoType");
            return (Criteria) this;
        }

        public Criteria andVideoTypeIn(List<String> values) {
            addCriterion("VIDEO_TYPE in", values, "videoType");
            return (Criteria) this;
        }

        public Criteria andVideoTypeNotIn(List<String> values) {
            addCriterion("VIDEO_TYPE not in", values, "videoType");
            return (Criteria) this;
        }

        public Criteria andVideoTypeBetween(String value1, String value2) {
            addCriterion("VIDEO_TYPE between", value1, value2, "videoType");
            return (Criteria) this;
        }

        public Criteria andVideoTypeNotBetween(String value1, String value2) {
            addCriterion("VIDEO_TYPE not between", value1, value2, "videoType");
            return (Criteria) this;
        }

        public Criteria andTypeNoIsNull() {
            addCriterion("TYPE_NO is null");
            return (Criteria) this;
        }

        public Criteria andTypeNoIsNotNull() {
            addCriterion("TYPE_NO is not null");
            return (Criteria) this;
        }

        public Criteria andTypeNoEqualTo(String value) {
            addCriterion("TYPE_NO =", value, "typeNo");
            return (Criteria) this;
        }

        public Criteria andTypeNoNotEqualTo(String value) {
            addCriterion("TYPE_NO <>", value, "typeNo");
            return (Criteria) this;
        }

        public Criteria andTypeNoGreaterThan(String value) {
            addCriterion("TYPE_NO >", value, "typeNo");
            return (Criteria) this;
        }

        public Criteria andTypeNoGreaterThanOrEqualTo(String value) {
            addCriterion("TYPE_NO >=", value, "typeNo");
            return (Criteria) this;
        }

        public Criteria andTypeNoLessThan(String value) {
            addCriterion("TYPE_NO <", value, "typeNo");
            return (Criteria) this;
        }

        public Criteria andTypeNoLessThanOrEqualTo(String value) {
            addCriterion("TYPE_NO <=", value, "typeNo");
            return (Criteria) this;
        }

        public Criteria andTypeNoLike(String value) {
            addCriterion("TYPE_NO like", value, "typeNo");
            return (Criteria) this;
        }

        public Criteria andTypeNoNotLike(String value) {
            addCriterion("TYPE_NO not like", value, "typeNo");
            return (Criteria) this;
        }

        public Criteria andTypeNoIn(List<String> values) {
            addCriterion("TYPE_NO in", values, "typeNo");
            return (Criteria) this;
        }

        public Criteria andTypeNoNotIn(List<String> values) {
            addCriterion("TYPE_NO not in", values, "typeNo");
            return (Criteria) this;
        }

        public Criteria andTypeNoBetween(String value1, String value2) {
            addCriterion("TYPE_NO between", value1, value2, "typeNo");
            return (Criteria) this;
        }

        public Criteria andTypeNoNotBetween(String value1, String value2) {
            addCriterion("TYPE_NO not between", value1, value2, "typeNo");
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

        public Criteria andOpTimeEqualTo(Date value) {
            addCriterion("OP_TIME =", value, "opTime");
            return (Criteria) this;
        }

        public Criteria andOpTimeNotEqualTo(Date value) {
            addCriterion("OP_TIME <>", value, "opTime");
            return (Criteria) this;
        }

        public Criteria andOpTimeGreaterThan(Date value) {
            addCriterion("OP_TIME >", value, "opTime");
            return (Criteria) this;
        }

        public Criteria andOpTimeGreaterThanOrEqualTo(Date value) {
            addCriterion("OP_TIME >=", value, "opTime");
            return (Criteria) this;
        }

        public Criteria andOpTimeLessThan(Date value) {
            addCriterion("OP_TIME <", value, "opTime");
            return (Criteria) this;
        }

        public Criteria andOpTimeLessThanOrEqualTo(Date value) {
            addCriterion("OP_TIME <=", value, "opTime");
            return (Criteria) this;
        }

        public Criteria andOpTimeIn(List<Date> values) {
            addCriterion("OP_TIME in", values, "opTime");
            return (Criteria) this;
        }

        public Criteria andOpTimeNotIn(List<Date> values) {
            addCriterion("OP_TIME not in", values, "opTime");
            return (Criteria) this;
        }

        public Criteria andOpTimeBetween(Date value1, Date value2) {
            addCriterion("OP_TIME between", value1, value2, "opTime");
            return (Criteria) this;
        }

        public Criteria andOpTimeNotBetween(Date value1, Date value2) {
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