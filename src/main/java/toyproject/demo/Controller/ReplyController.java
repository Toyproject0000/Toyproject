package toyproject.demo.Controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import toyproject.demo.domain.Follow;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.Reply;
import toyproject.demo.domain.User;
import toyproject.demo.service.ReplyService;

@RestController
@RequestMapping("/reply")
public class ReplyController {

    /*
    * 답글 작성
    * 답글 수정
    * 답글 삭제
    * 글에 답글 찾기
    * 유저가 쓴 답글 찾기
    * */
    private final ReplyService replyService;

    public ReplyController(ReplyService replyService) {
        this.replyService = replyService;
    }

    @PostMapping("/add")
    public String add(@RequestBody Reply reply){
        try {
            replyService.add(reply);
            return "ok";
        }catch (Exception e){
            return "에러 발생"; // 작성했던 글 내용 그대로 다시 쓸수있는지 아니면 내가 다시 보내줘야되는지 물어보자
        }
    }

    @PostMapping("/delete")
    public String delete(@RequestBody Reply reply){
        try {
            replyService.delete(reply);
            return "ok";
        }catch (Exception e){
            return "에러 발생"; // 작성했던 글 내용 그대로 다시 쓸수있는지 아니면 내가 다시 보내줘야되는지 물어보자
        }
    }
    @PostMapping("/edit")
    public String edit(@RequestBody Reply reply){
        try {
            replyService.edit(reply);
            return "ok";
        }catch (Exception e){
            return "에러 발생"; // 작성했던 글 내용 그대로 다시 쓸수있는지 아니면 내가 다시 보내줘야되는지 물어보자
        }
    }

    @PostMapping("/myReply")
    public String findPost(@RequestBody Post post){
        try {
            replyService.findReplyOfPost(post);
            return "ok";
        }catch (Exception e){
            return "에러 발생";
        }
    }
}
