package toyproject.demo.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import toyproject.demo.domain.Category;
import toyproject.demo.domain.Post;
import toyproject.demo.repository.CategoryRepository;

import java.util.List;

@Service
@RequiredArgsConstructor
public class FindAlgorithm {

    private final CategoryRepository categoryRepository;
    public void write(Post post){
        categoryRepository.plus(post, 3);
    }

    public void read(Post post){
        categoryRepository.plus(post, 2);
    }

    public void block(Post post){
        categoryRepository.minus(post, 5);
    }

    public List<Category> findCategory(String userId){
        return categoryRepository.findByUser(userId);
    }

}
