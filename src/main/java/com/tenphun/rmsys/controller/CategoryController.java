package com.tenphun.rmsys.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.tenphun.rmsys.common.BusinessException;
import com.tenphun.rmsys.common.R;
import com.tenphun.rmsys.entity.Category;
import com.tenphun.rmsys.service.CategoryService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/category")
public class CategoryController {

    @Autowired
    CategoryService categoryService;

    /**
     * Show Category By page
     */
    @GetMapping("/page")
    public R<Page<Category>> page(int page, int pageSize){
        Page<Category> pageInfo = new Page<>(page, pageSize);

        // Create Condition Constructor
        LambdaQueryWrapper<Category> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByAsc(Category::getSort);
        categoryService.page(pageInfo, wrapper);

        return R.success(pageInfo);
    }

    /**
     * Add a Category
     */
    @PostMapping
    public R<String> add(@RequestBody Category c){
        log.info("[INFO] {}", c);
        try {
            categoryService.save(c);
        } catch (Exception e) {
            throw new BusinessException("Category " + c.getName() + " existed");
        }
        return R.success("Add 1");
    }

    /**
     * Update Category Info
     */
    @PutMapping
    public R<String> update(@RequestBody Category c){
        categoryService.updateById(c);
        return R.success("Update 1");
    }


    /**
     * Delete a Category
     */
    @DeleteMapping
    public R<String> delete(Long id){
        categoryService.remove(id);
        return R.success("Delete 1");
    }
}
