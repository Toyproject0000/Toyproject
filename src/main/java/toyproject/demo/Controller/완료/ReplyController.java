package toyproject.demo.Controller.완료;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import toyproject.demo.converter.PostConverter;
import toyproject.demo.converter.ReplyConverter;
import toyproject.demo.domain.DTO.PostWithTokenDTO;
import toyproject.demo.domain.DTO.ReplyWithTokenDTO;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.Reply;
import toyproject.demo.service.JwtTokenUtil;
import toyproject.demo.service.ReplyService;

@RestController
@RequestMapping("/reply")
@RequiredArgsConstructor
public class ReplyController {

    /*
    * 답글 작성
    * 답글 수정
    * 답글 삭제
    * 글에 답글 찾기
    * 유저가 쓴 답글 찾기
    * */
    private final ReplyService replyService;
    private final JwtTokenUtil tokenUtil;
    private final ReplyConverter replyConverter;
    private final PostConverter postConverter;

    @PostMapping("/add")
    public String add(@RequestBody ReplyWithTokenDTO tokenReply){
        try {
            tokenUtil.parseJwtToken(tokenReply.getToken());
        }catch (Exception e){
            return "잘못된 접근입니다.";
        }
        Reply reply = replyConverter.convert(tokenReply);

        try {
            replyService.add(reply);
            return "ok";
        }catch (Exception e){
            return "에러 발생"; // 작성했던 글 내용 그대로 다시 쓸수있는지 아니면 내가 다시 보내줘야되는지 물어보자
        }
    }

    @PostMapping("/delete")
    public String delete(@RequestBody ReplyWithTokenDTO tokenReply){
        try {
            tokenUtil.parseJwtToken(tokenReply.getToken());
        }catch (Exception e){
            return "잘못된 접근입니다.";
        }
        Reply reply = replyConverter.convert(tokenReply);
        try {
            replyService.delete(reply);
            return "ok";
        }catch (Exception e){
            return "에러 발생"; // 작성했던 글 내용 그대로 다시 쓸수있는지 아니면 내가 다시 보내줘야되는지 물어보자
        }
    }
    @PostMapping("/edit")
    public String edit(@RequestBody ReplyWithTokenDTO tokenReply){
        try {
            tokenUtil.parseJwtToken(tokenReply.getToken());
        }catch (Exception e){
            return "잘못된 접근입니다.";
        }
        Reply reply = replyConverter.convert(tokenReply);

        try {
            replyService.edit(reply);
            return "ok";
        }catch (Exception e){
            return "에러 발생"; // 작성했던 글 내용 그대로 다시 쓸수있는지 아니면 내가 다시 보내줘야되는지 물어보자
        }
    }

    @PostMapping("/post")
    public String findPost(@RequestBody PostWithTokenDTO tokenPost){
        try {
            tokenUtil.parseJwtToken(tokenPost.getToken());
        }catch (Exception e){
            return "잘못된 접근입니다.";
        }
        Post post = postConverter.convert(tokenPost);
        try {
            replyService.findReplyOfPost(post);
            return "ok";
        }catch (Exception e){
            return "에러 발생";
        }
    }
}
