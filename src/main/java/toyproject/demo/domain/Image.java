package toyproject.demo.domain;

import org.springframework.data.annotation.Id;

import java.time.LocalDateTime;

public class Image {
    @Id
    private Long id;

    private String author;

    private String title;


    private String content;


    private Long fileId;


    private LocalDateTime createdDate;


    private LocalDateTime modifiedDate;


    public Image(Long id, String author, String title, String content, Long fileId) {
        this.id = id;
        this.author = author;
        this.title = title;
        this.content = content;
        this.fileId = fileId;
    }
}
