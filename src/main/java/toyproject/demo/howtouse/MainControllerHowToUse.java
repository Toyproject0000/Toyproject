package toyproject.demo.howtouse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import toyproject.demo.domain.DTO.PostWithTokenDTO;
import toyproject.demo.domain.Post;

import java.util.List;

@Controller
public class MainControllerHowToUse {
    @GetMapping("/main/recommend")
    public String mainRecommend(){
        return "post/Main";
    }

    @PostMapping(value = "/recommend/category")
    public String recommendWithCategory(@RequestBody PostWithTokenDTO tokenPost){

        return "post/category";
    }
}
