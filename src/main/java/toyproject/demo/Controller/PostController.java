package toyproject.demo.Controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;
import toyproject.demo.service.PostService;

import java.time.LocalDate;

@RestController
@RequestMapping("/post")
public class PostController {
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
    private final PostService postService;

    public PostController(PostService postService) {
        this.postService = postService;
    }

    @PostMapping("/submit")
    public String submitPost(@RequestBody Post post){
        try {
            postService.submit(post);
            return "ok";
        }catch (Exception e){
            return "에러 발생"; // 작성했던 글 내용 그대로 다시 쓸수있는지 아니면 내가 다시 보내줘야되는지 물어보자
        }
    }

    @PostMapping("/edit")
    public String edit(@RequestBody Post post){
        try {
            postService.modify(post);
            return "ok";
        }catch (Exception e){
            return "에러 발생"; // 작성했던 글 내용 그대로 다시 쓸수있는지 아니면 내가 다시 보내줘야되는지 물어보자
        }
    }

    @PostMapping("/delete")
    public String delete(@RequestBody Post post){
        try {
            postService.delete(post);
            return "ok";
        }catch (Exception e){
            return "에러 발생"; // 작성했던 글 내용 그대로 다시 쓸수있는지 아니면 내가 다시 보내줘야되는지 물어보자
        }
    }

    @PostMapping("/find-bycontent")
    public String findPostByContents(@RequestBody Post post){
        try {
            postService.findPostByContents(post);
            return "ok";
        }catch (Exception e){
            return "에러 발생"; // 작성했던 글 내용 그대로 다시 쓸수있는지 아니면 내가 다시 보내줘야되는지 물어보자
        }
    }

    @PostMapping("/find-mypost-bycontent")
    public String findMyPostByContents(@RequestBody Post post,@RequestBody User user){
        try {
            postService.findMyPostByContents(post, user);
            return "ok";
        }catch (Exception e){
            return "에러 발생"; // 작성했던 글 내용 그대로 다시 쓸수있는지 아니면 내가 다시 보내줘야되는지 물어보자
        }
    }

    @PostMapping("/find-byuser")
    public String findPostByUser(@RequestBody User user){
        try {
            postService.findUserAllPost(user);
            return "ok";
        }catch (Exception e){
            return "에러 발생"; // 작성했던 글 내용 그대로 다시 쓸수있는지 아니면 내가 다시 보내줘야되는지 물어보자
        }
    }

    @PostMapping("/find-follower")
    public String findPostOfFollower(@RequestBody User user){
        try {
            postService.findPostByFollower(user);
            return "ok";
        }catch (Exception e){
            return "에러 발생"; // 작성했던 글 내용 그대로 다시 쓸수있는지 아니면 내가 다시 보내줘야되는지 물어보자
        }
    }

    @PostMapping("/find-likepost")
    public String findLikePost(@RequestBody User user){
        try {
            postService.findAllLikePost(user);
            return "ok";
        }catch (Exception e){
            return "에러 발생"; // 작성했던 글 내용 그대로 다시 쓸수있는지 아니면 내가 다시 보내줘야되는지 물어보자
        }
    }

    @PostMapping("/find-specific")
    public String findPostSpecificDate(@RequestBody LocalDate date){
        try {
            postService.findPostBySpecificDate(date);
            return "ok";
        }catch (Exception e){
            return "에러 발생"; // 작성했던 글 내용 그대로 다시 쓸수있는지 아니면 내가 다시 보내줘야되는지 물어보자
        }
    }
    @PostMapping("/find-after")
    public String findPostAfterDate(@RequestBody LocalDate date){
        try {
            postService.findPostAfterDate(date);
            return "ok";
        }catch (Exception e){
            return "에러 발생"; // 작성했던 글 내용 그대로 다시 쓸수있는지 아니면 내가 다시 보내줘야되는지 물어보자
        }
    }

}
