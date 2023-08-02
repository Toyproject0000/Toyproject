package toyproject.demo.howtouse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;


@Controller
@RequestMapping("/post")
public class PostControllerHowToUse {
    /*
     * 글쓰기
     * 글수정
     * 글삭제
     * 내용으로 글검색
     * 유저 글 검색(내 글 검색)
     * 내 글 내용으로 검색
     * 팔로워 글검색(모든 팔로워)
     * 좋아요한 글검색
     * 날짜로 글 검색
     * 특정날짜이후로 쓴 글 검색
     * */

    @GetMapping("/submit")
    public String submitPost(){
        return "post/post-submit";
    }

    @GetMapping("/read")
    public String read(){
        return "post/post-read";
    }

    @GetMapping("edit")
    public String editConfirm(){
        return "post/post-edit";
    }

    @GetMapping("/delete")
    public String delete(){
        return "post/post-delete";
    }


    @GetMapping("/search")
    public String search(){
        return "post/post-search";
    }

    @GetMapping("/find-mypost-bycontent")
    public String findMyPostByContents(){
        return "post/mypost";
    }

    @GetMapping("/find-follower")
    public String findPostOfFollower(){
        return "post/post-follower";
    }

    @GetMapping("/find-likepost")
    public String findLikePost(){
        return "post/post-likepost";
    }
}
