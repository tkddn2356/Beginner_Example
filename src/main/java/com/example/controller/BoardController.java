package com.example.controller;

import com.example.domain.Board;
import com.example.service.BoardService;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import io.swagger.annotations.Authorization;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class BoardController {

    @Autowired
    private BoardService boardService;

    @RequestMapping(value = "/board/read", method = RequestMethod.GET)
    public String read(@RequestParam("id") Long id, Model model){
        model.addAttribute("id", id);
        return "board/read";
    }

    @RequestMapping(value = "/board/write", method = RequestMethod.GET)
    public String write(){
        return "board/write";
    }

    @ResponseBody
    @RequestMapping(value = "/boards", method = RequestMethod.GET)
    public ResponseEntity<List<Board>> getList(){
        return new ResponseEntity<>(boardService.getList(), HttpStatus.OK);
    }

    @ResponseBody
    @RequestMapping(value = "/api/board/{id}", method=RequestMethod.GET)
    public ResponseEntity<Board> read(@PathVariable("id") Long id) {
        return new ResponseEntity<>(boardService.getBoard(id), HttpStatus.OK);
    }

    @ApiOperation(value = "게시글작성", authorizations = {@Authorization(value="Authorization")})
    @ResponseBody
    @RequestMapping(value="/api/board",  method =  RequestMethod.POST, consumes = "application/json")
    public ResponseEntity<String> write(@ApiParam(value = "(required: title, content)", required = true) @RequestBody Board board){
        return boardService.createBoard(board) ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
    }

}
