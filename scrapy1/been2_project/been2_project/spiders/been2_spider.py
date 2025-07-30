import scrapy


class Been2SpiderSpider(scrapy.Spider):
    name = "been2_spider"
    allowed_domains = ["davelee-fun.github.io"]
    start_urls = ["https://davelee-fun.github.io"]

    def parse(self, response):
        item = Been2SpiderSpider()
        item["title"]=response.css("h1.sitetitle::text").get()
        description = response.xpath("//p[@class='lead']/text()").get()
        item["description"]=description
        yield

