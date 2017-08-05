package com.belong.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ClassifyDetailConfigExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public ClassifyDetailConfigExample() {
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

        public Criteria andTypeDtlhrefIsNull() {
            addCriterion("TYPE_DTLHREF is null");
            return (Criteria) this;
        }

        public Criteria andTypeDtlhrefIsNotNull() {
            addCriterion("TYPE_DTLHREF is not null");
            return (Criteria) this;
        }

        public Criteria andTypeDtlhrefEqualTo(String value) {
            addCriterion("TYPE_DTLHREF =", value, "typeDtlhref");
            return (Criteria) this;
        }

        public Criteria andTypeDtlhrefNotEqualTo(String value) {
            addCriterion("TYPE_DTLHREF <>", value, "typeDtlhref");
            return (Criteria) this;
        }

        public Criteria andTypeDtlhrefGreaterThan(String value) {
            addCriterion("TYPE_DTLHREF >", value, "typeDtlhref");
            return (Criteria) this;
        }

        public Criteria andTypeDtlhrefGreaterThanOrEqualTo(String value) {
            addCriterion("TYPE_DTLHREF >=", value, "typeDtlhref");
            return (Criteria) this;
        }

        public Criteria andTypeDtlhrefLessThan(String value) {
            addCriterion("TYPE_DTLHREF <", value, "typeDtlhref");
            return (Criteria) this;
        }

        public Criteria andTypeDtlhrefLessThanOrEqualTo(String value) {
            addCriterion("TYPE_DTLHREF <=", value, "typeDtlhref");
            return (Criteria) this;
        }

        public Criteria andTypeDtlhrefLike(String value) {
            addCriterion("TYPE_DTLHREF like", value, "typeDtlhref");
            return (Criteria) this;
        }

        public Criteria andTypeDtlhrefNotLike(String value) {
            addCriterion("TYPE_DTLHREF not like", value, "typeDtlhref");
            return (Criteria) this;
        }

        public Criteria andTypeDtlhrefIn(List<String> values) {
            addCriterion("TYPE_DTLHREF in", values, "typeDtlhref");
            return (Criteria) this;
        }

        public Criteria andTypeDtlhrefNotIn(List<String> values) {
            addCriterion("TYPE_DTLHREF not in", values, "typeDtlhref");
            return (Criteria) this;
        }

        public Criteria andTypeDtlhrefBetween(String value1, String value2) {
            addCriterion("TYPE_DTLHREF between", value1, value2, "typeDtlhref");
            return (Criteria) this;
        }

        public Criteria andTypeDtlhrefNotBetween(String value1, String value2) {
            addCriterion("TYPE_DTLHREF not between", value1, value2, "typeDtlhref");
            return (Criteria) this;
        }

        public Criteria andTypeDtlnameIsNull() {
            addCriterion("TYPE_DTLNAME is null");
            return (Criteria) this;
        }

        public Criteria andTypeDtlnameIsNotNull() {
            addCriterion("TYPE_DTLNAME is not null");
            return (Criteria) this;
        }

        public Criteria andTypeDtlnameEqualTo(String value) {
            addCriterion("TYPE_DTLNAME =", value, "typeDtlname");
            return (Criteria) this;
        }

        public Criteria andTypeDtlnameNotEqualTo(String value) {
            addCriterion("TYPE_DTLNAME <>", value, "typeDtlname");
            return (Criteria) this;
        }

        public Criteria andTypeDtlnameGreaterThan(String value) {
            addCriterion("TYPE_DTLNAME >", value, "typeDtlname");
            return (Criteria) this;
        }

        public Criteria andTypeDtlnameGreaterThanOrEqualTo(String value) {
            addCriterion("TYPE_DTLNAME >=", value, "typeDtlname");
            return (Criteria) this;
        }

        public Criteria andTypeDtlnameLessThan(String value) {
            addCriterion("TYPE_DTLNAME <", value, "typeDtlname");
            return (Criteria) this;
        }

        public Criteria andTypeDtlnameLessThanOrEqualTo(String value) {
            addCriterion("TYPE_DTLNAME <=", value, "typeDtlname");
            return (Criteria) this;
        }

        public Criteria andTypeDtlnameLike(String value) {
            addCriterion("TYPE_DTLNAME like", value, "typeDtlname");
            return (Criteria) this;
        }

        public Criteria andTypeDtlnameNotLike(String value) {
            addCriterion("TYPE_DTLNAME not like", value, "typeDtlname");
            return (Criteria) this;
        }

        public Criteria andTypeDtlnameIn(List<String> values) {
            addCriterion("TYPE_DTLNAME in", values, "typeDtlname");
            return (Criteria) this;
        }

        public Criteria andTypeDtlnameNotIn(List<String> values) {
            addCriterion("TYPE_DTLNAME not in", values, "typeDtlname");
            return (Criteria) this;
        }

        public Criteria andTypeDtlnameBetween(String value1, String value2) {
            addCriterion("TYPE_DTLNAME between", value1, value2, "typeDtlname");
            return (Criteria) this;
        }

        public Criteria andTypeDtlnameNotBetween(String value1, String value2) {
            addCriterion("TYPE_DTLNAME not between", value1, value2, "typeDtlname");
            return (Criteria) this;
        }

        public Criteria andTypeNameIsNull() {
            addCriterion("TYPE_NAME is null");
            return (Criteria) this;
        }

        public Criteria andTypeNameIsNotNull() {
            addCriterion("TYPE_NAME is not null");
            return (Criteria) this;
        }

        public Criteria andTypeNameEqualTo(String value) {
            addCriterion("TYPE_NAME =", value, "typeName");
            return (Criteria) this;
        }

        public Criteria andTypeNameNotEqualTo(String value) {
            addCriterion("TYPE_NAME <>", value, "typeName");
            return (Criteria) this;
        }

        public Criteria andTypeNameGreaterThan(String value) {
            addCriterion("TYPE_NAME >", value, "typeName");
            return (Criteria) this;
        }

        public Criteria andTypeNameGreaterThanOrEqualTo(String value) {
            addCriterion("TYPE_NAME >=", value, "typeName");
            return (Criteria) this;
        }

        public Criteria andTypeNameLessThan(String value) {
            addCriterion("TYPE_NAME <", value, "typeName");
            return (Criteria) this;
        }

        public Criteria andTypeNameLessThanOrEqualTo(String value) {
            addCriterion("TYPE_NAME <=", value, "typeName");
            return (Criteria) this;
        }

        public Criteria andTypeNameLike(String value) {
            addCriterion("TYPE_NAME like", value, "typeName");
            return (Criteria) this;
        }

        public Criteria andTypeNameNotLike(String value) {
            addCriterion("TYPE_NAME not like", value, "typeName");
            return (Criteria) this;
        }

        public Criteria andTypeNameIn(List<String> values) {
            addCriterion("TYPE_NAME in", values, "typeName");
            return (Criteria) this;
        }

        public Criteria andTypeNameNotIn(List<String> values) {
            addCriterion("TYPE_NAME not in", values, "typeName");
            return (Criteria) this;
        }

        public Criteria andTypeNameBetween(String value1, String value2) {
            addCriterion("TYPE_NAME between", value1, value2, "typeName");
            return (Criteria) this;
        }

        public Criteria andTypeNameNotBetween(String value1, String value2) {
            addCriterion("TYPE_NAME not between", value1, value2, "typeName");
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

        public Criteria andPagerIsNull() {
            addCriterion("pager is null");
            return (Criteria) this;
        }

        public Criteria andPagerIsNotNull() {
            addCriterion("pager is not null");
            return (Criteria) this;
        }

        public Criteria andPagerEqualTo(String value) {
            addCriterion("pager =", value, "pager");
            return (Criteria) this;
        }

        public Criteria andPagerNotEqualTo(String value) {
            addCriterion("pager <>", value, "pager");
            return (Criteria) this;
        }

        public Criteria andPagerGreaterThan(String value) {
            addCriterion("pager >", value, "pager");
            return (Criteria) this;
        }

        public Criteria andPagerGreaterThanOrEqualTo(String value) {
            addCriterion("pager >=", value, "pager");
            return (Criteria) this;
        }

        public Criteria andPagerLessThan(String value) {
            addCriterion("pager <", value, "pager");
            return (Criteria) this;
        }

        public Criteria andPagerLessThanOrEqualTo(String value) {
            addCriterion("pager <=", value, "pager");
            return (Criteria) this;
        }

        public Criteria andPagerLike(String value) {
            addCriterion("pager like", value, "pager");
            return (Criteria) this;
        }

        public Criteria andPagerNotLike(String value) {
            addCriterion("pager not like", value, "pager");
            return (Criteria) this;
        }

        public Criteria andPagerIn(List<String> values) {
            addCriterion("pager in", values, "pager");
            return (Criteria) this;
        }

        public Criteria andPagerNotIn(List<String> values) {
            addCriterion("pager not in", values, "pager");
            return (Criteria) this;
        }

        public Criteria andPagerBetween(String value1, String value2) {
            addCriterion("pager between", value1, value2, "pager");
            return (Criteria) this;
        }

        public Criteria andPagerNotBetween(String value1, String value2) {
            addCriterion("pager not between", value1, value2, "pager");
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