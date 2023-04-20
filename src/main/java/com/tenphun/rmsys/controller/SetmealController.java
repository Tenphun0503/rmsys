package com.tenphun.rmsys.controller;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.tenphun.rmsys.common.R;
import com.tenphun.rmsys.entity.Setmeal;
import com.tenphun.rmsys.service.SetmealService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("setmeal")
public class SetmealController {
    @Autowired
    SetmealService setmealService;

    @GetMapping("/page")
    public R<Page<Setmeal>> page(int page, int pageSize, String name){
        Page<Setmeal> pageInfo = new Page<>(page, pageSize);

        LambdaQueryWrapper<Setmeal> wrapper = new LambdaQueryWrapper<>();
        wrapper.like(StringUtils.isNotEmpty(name), Setmeal::getName, name);
        wrapper.orderByDesc(Setmeal::getUpdateTime);

        setmealService.page(pageInfo, wrapper);
        return R.success(pageInfo);
    }
}
