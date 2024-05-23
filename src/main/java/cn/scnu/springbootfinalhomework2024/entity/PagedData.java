package cn.scnu.springbootfinalhomework2024.entity;

import lombok.Data;

import java.util.List;

@Data
public class PagedData<T> {
    private int currentPage;
    private int totalPages;
    private long totalItems;
    private List<T> data;

    public PagedData(int currentPage, int totalPages, long totalItems, List<T> data) {
        this.currentPage = currentPage;
        this.totalPages = totalPages;
        this.totalItems = totalItems;
        this.data = data;
    }
}
