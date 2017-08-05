package com.belong.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class VideoTypeConfigExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public VideoTypeConfigExample() {
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

        public Criteria andVideoNoIsNull() {
            addCriterion("video_no is null");
            return (Criteria) this;
        }

        public Criteria andVideoNoIsNotNull() {
            addCriterion("video_no is not null");
            return (Criteria) this;
        }

        public Criteria andVideoNoEqualTo(String value) {
            addCriterion("video_no =", value, "videoNo");
            return (Criteria) this;
        }

        public Criteria andVideoNoNotEqualTo(String value) {
            addCriterion("video_no <>", value, "videoNo");
            return (Criteria) this;
        }

        public Criteria andVideoNoGreaterThan(String value) {
            addCriterion("video_no >", value, "videoNo");
            return (Criteria) this;
        }

        public Criteria andVideoNoGreaterThanOrEqualTo(String value) {
            addCriterion("video_no >=", value, "videoNo");
            return (Criteria) this;
        }

        public Criteria andVideoNoLessThan(String value) {
            addCriterion("video_no <", value, "videoNo");
            return (Criteria) this;
        }

        public Criteria andVideoNoLessThanOrEqualTo(String value) {
            addCriterion("video_no <=", value, "videoNo");
            return (Criteria) this;
        }

        public Criteria andVideoNoLike(String value) {
            addCriterion("video_no like", value, "videoNo");
            return (Criteria) this;
        }

        public Criteria andVideoNoNotLike(String value) {
            addCriterion("video_no not like", value, "videoNo");
            return (Criteria) this;
        }

        public Criteria andVideoNoIn(List<String> values) {
            addCriterion("video_no in", values, "videoNo");
            return (Criteria) this;
        }

        public Criteria andVideoNoNotIn(List<String> values) {
            addCriterion("video_no not in", values, "videoNo");
            return (Criteria) this;
        }

        public Criteria andVideoNoBetween(String value1, String value2) {
            addCriterion("video_no between", value1, value2, "videoNo");
            return (Criteria) this;
        }

        public Criteria andVideoNoNotBetween(String value1, String value2) {
            addCriterion("video_no not between", value1, value2, "videoNo");
            return (Criteria) this;
        }

        public Criteria andVideoTypeIsNull() {
            addCriterion("video_type is null");
            return (Criteria) this;
        }

        public Criteria andVideoTypeIsNotNull() {
            addCriterion("video_type is not null");
            return (Criteria) this;
        }

        public Criteria andVideoTypeEqualTo(String value) {
            addCriterion("video_type =", value, "videoType");
            return (Criteria) this;
        }

        public Criteria andVideoTypeNotEqualTo(String value) {
            addCriterion("video_type <>", value, "videoType");
            return (Criteria) this;
        }

        public Criteria andVideoTypeGreaterThan(String value) {
            addCriterion("video_type >", value, "videoType");
            return (Criteria) this;
        }

        public Criteria andVideoTypeGreaterThanOrEqualTo(String value) {
            addCriterion("video_type >=", value, "videoType");
            return (Criteria) this;
        }

        public Criteria andVideoTypeLessThan(String value) {
            addCriterion("video_type <", value, "videoType");
            return (Criteria) this;
        }

        public Criteria andVideoTypeLessThanOrEqualTo(String value) {
            addCriterion("video_type <=", value, "videoType");
            return (Criteria) this;
        }

        public Criteria andVideoTypeLike(String value) {
            addCriterion("video_type like", value, "videoType");
            return (Criteria) this;
        }

        public Criteria andVideoTypeNotLike(String value) {
            addCriterion("video_type not like", value, "videoType");
            return (Criteria) this;
        }

        public Criteria andVideoTypeIn(List<String> values) {
            addCriterion("video_type in", values, "videoType");
            return (Criteria) this;
        }

        public Criteria andVideoTypeNotIn(List<String> values) {
            addCriterion("video_type not in", values, "videoType");
            return (Criteria) this;
        }

        public Criteria andVideoTypeBetween(String value1, String value2) {
            addCriterion("video_type between", value1, value2, "videoType");
            return (Criteria) this;
        }

        public Criteria andVideoTypeNotBetween(String value1, String value2) {
            addCriterion("video_type not between", value1, value2, "videoType");
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