import scrapy
from been3_project.items import Been3ProjectItem


class CategorySpiderSpider(scrapy.Spider):
    name = "category_spider"
    allowed_domains = ["davelee-fun.github.io"]
    start_urls = ["https://davelee-fun.github.io"]

    def parse(self, response):
        categories = response.css("a.text-dark::text").getall() #리스트 형식이다!
        for category in categories :
            item = Been3ProjectItem()
            item["category"] = category
            yield item


        
