package com.example.repository;


import com.example.domain.Board;
import com.example.domain.User;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BoardMapper {
    public List<Board> getList();
    public Board getBoard(Long id);
    public int createBoard(Board board);

    //메소드 이름은 자유롭게 하시면 됩니다. 네이밍 규칙만 잘 지켜주세요. (현재 위와 같은 예시는 카멜표기법이라 합니다)

}
