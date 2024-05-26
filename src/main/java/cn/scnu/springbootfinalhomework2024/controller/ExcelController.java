package cn.scnu.springbootfinalhomework2024.controller;

import cn.scnu.springbootfinalhomework2024.entity.Movie;
import cn.scnu.springbootfinalhomework2024.service.MovieService;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

@Controller
public class ExcelController {

    @Autowired
    private MovieService movieService;
    @RequestMapping("/testExcel")
    public void downloadExcelFile(HttpServletResponse response) throws IOException {
        // 1. 从数据库获取movie数据
        List<Movie> movies = movieService.findAllMovie();

        // 2. 创建Excel工作簿和工作表
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Movie List");

        // 3. 设置表格标题和列标题
        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("Movie Title");
        headerRow.createCell(1).setCellValue("Cover URL");
        headerRow.createCell(2).setCellValue("Description");
        headerRow.createCell(3).setCellValue("Release Date");
        headerRow.createCell(4).setCellValue("Need VIP");
        headerRow.createCell(5).setCellValue("Local URL");
        headerRow.createCell(6).setCellValue("Region");
        headerRow.createCell(7).setCellValue("Type");
        headerRow.createCell(8).setCellValue("Score");

        // 4. 写入数据
        int rowNum = 1;
        for (Movie movie : movies) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(movie.getMovieTitle());
            row.createCell(1).setCellValue(movie.getMovieCoverUrl());
            row.createCell(2).setCellValue(movie.getMovieDescription());
            row.createCell(3).setCellValue(movie.getReleaseDate().toString());
            row.createCell(4).setCellValue(movie.getNeedVip());
            row.createCell(5).setCellValue(movie.getMovieLocalUrl());
            row.createCell(6).setCellValue(movie.getMovieRegion());
            row.createCell(7).setCellValue(movie.getMovieType());
            row.createCell(8).setCellValue(movie.getMovieScore());
        }

        // 5. 设置响应头
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment; filename=movies.xlsx");

        // 6. 将Excel写入响应输出流
        workbook.write(response.getOutputStream());
        workbook.close();

    }
}
