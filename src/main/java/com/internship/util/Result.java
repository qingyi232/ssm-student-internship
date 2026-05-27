package com.internship.util;

/**
 * 通用JSON响应封装类
 */
public class Result {

    private boolean success;
    private String message;
    private Object data;

    public Result() {
    }

    public Result(boolean success, String message, Object data) {
        this.success = success;
        this.message = message;
        this.data = data;
    }

    /**
     * 成功响应，无数据
     */
    public static Result success() {
        return new Result(true, null, null);
    }

    /**
     * 成功响应，带数据
     */
    public static Result success(Object data) {
        return new Result(true, null, data);
    }

    /**
     * 成功响应，带消息和数据
     */
    public static Result success(String message, Object data) {
        return new Result(true, message, data);
    }

    /**
     * 失败响应，带错误消息
     */
    public static Result error(String message) {
        return new Result(false, message, null);
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
