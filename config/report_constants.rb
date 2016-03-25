class Config_ReportConstants
  # Styles CSS
  CSS = ' html * { margin: 0; padding: 0; }
          body {width: 800px; margin: 0 auto; margin-top: 30px;font-family: verdana; font-size: 12px; }
          table.main { margin: auto; padding-bottom: 10px;}
          table tbody tr td { padding: 5px; }
          div.title h3 { padding-bottom: 10px; font-size: 18px;}
          hr { border: 1px dotted #333333; margin-top: 15px; margin-bottom: 15px; clear: both; }
          ul { padding-bottom: 15px; padding-left: 30px; }
          ul li { list-style-type: none; }
          li div.icon { padding: 0; margin: 8px 2px 0 0; width: 10px; height: auto; background: url("'+
          'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAAABGdBTUEAALGPC/xhBQAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9wGDhQFGl2N8vQAAACaSURBVBjTlc8hDsJAEIXhP4SgsCQcAFs1k54Ht4oEia7hAphRvQAHqEJhmsxKBCk3qMJWYboJIZQNz0wy7xMz8G/EvBDzTc7NxlkANzE/ivkyhwEWwAHoxHybwylroBbzVszLHE4pgVbMazFf5TBAD1xj0B5gPoEG4ARUMegzLb/hBtjHoPfP4h0/gF0M2kzdlPAFOMegw68HXjP/KIRTt6mPAAAAAElFTkSuQmCC'+
          '") no-repeat scroll transparent; }
          div.passed { padding: 0; margin: 3px 0 0 0; width: 15px; height: 15px; background: url("'+
          'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA8AAAAPCAYAAAA71pVKAAAABGdBTUEAALGPC/xhBQAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9wGDhQGOKPA4NMAAAFGSURBVCjPpZI/LANhGMZ/Si3lgqlpohFlqfgzWNoFCUlrqgTrNYS53Sziku7XzkLoYDFVDEcMvQ4YRIIES4mIXMRAiy4slju5fHdq6Du935P8vu/53veBBqrJTYznA8NAAhg3pQugoMlGqS4czweyQOqPxwpAUpONKoBHALfqgJhudOvQbANlQHEjfF4JdXqfbinEuaH7+2faKRc+Sh7hVtdandgk1DVA7fvdkpKibVd4eVRhyB/lqLzLzqVqyT2OPwP0doZJR7P4vBKToTkS4SXuXq9ZP1tzXNxi6ytAx6A/ylTfPG2tEpFgjM+vKpnigt3yb3mENbB3u8HV8wmRYAyAlcNZXmpPIqeLcM5qMsVFTh8PUI9T3L/duI1CcYTEXNf2P6nMabKRdgxMk428OfUHF6hipitdN9umizFgxMq2mOuG6wdZ8104WuKulwAAAABJRU5ErkJggg%3D%3D'+
          '") no-repeat scroll transparent; }
          div.failed { padding: 0; margin: 3px 0 0 0; width: 15px; height: 15px; background: url("'+
          'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA8AAAAPCAYAAAA71pVKAAAABGdBTUEAALGPC/xhBQAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9wGDhU1LqK9WoUAAAFHSURBVCjPpZLNasJAFIWPTaRL4xO0K5dm495HsGsRWhR8AF9ExK1g36CPIN0qUqRLf1KhuDOO0E5Ip5nTRSY22saNA5eZ3OGee27mAy5YufQHgQKABwB3AG4BvJl4zAHPmSoEXAI7AsyIYVbhDYFd5LqUvs9gPKa2LGrbZjCZUG63jMrl/wUIPBn1ZTgYbKQQVO129NXp7KUQDPv9fcpB9WhOk3wh8KEdh3K5pFytKNdryvmculD4NPfH3QlUTfI1UVeNBqUQlEJQ1etxx3w+uR8ltVcp96XDybZ/s9fX8a5UKesvHzprx4ktLxZxeB51sZh2NjoV8JKZw243tttsUrValEIw7PVUaub70+IaAUaVyrv0fQbTqdKW9a1texPMZlL6PiPXJQEv662HZwChAcg9R1nNjPCHLoNuNttp4gzbOMv0JesHYDILvj+BVdIAAAAASUVORK5CYII%3D'+
          '") no-repeat scroll transparent; }
          div.crashed { padding: 0; margin: 3px 0 0 0; width: 15px; height: 15px; background: url("'+
          'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA8AAAAPCAYAAAA71pVKAAAAAXNSR0IArs4c6QAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9wGDhYDGZFa0KYAAACpSURBVCjPpZLLDcIwEESfJe4uATowHaSE0AGUkI5CKqAERAmpwO4gdDBc7ChE2nxgpb1Yejue3YE/ys0fBB64ARfgBKTcdwcvc5IgCAaBjG4t8LgC2gMEjw1g6erL5w5wVD9k/gyA99A09npTgq4jL3JUrgRSCFqsGIvyc6r8BqDvwbn9BxfEHZ6vc7jeCEZLvV0BB0FY+n5tWGhzdO1sTxNXTrKY6V/rA9mQ2FeZePiuAAAAAElFTkSuQmCC'+
          '") no-repeat scroll transparent; }
          div.missing { padding: 0; margin: 3px 0 0 0; width: 15px; height: 15px; background: url("'+
          'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA8AAAAPCAYAAAA71pVKAAAABGdBTUEAALGPC/xhBQAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9wGDhQHNypkzAMAAAEzSURBVCjPzZJNTsJQFIU/GzoraZkXcWD8iYD1J8YhTdM5O9AlsASWoDtgCcybpm6AUAcaow4UiCVCYo2d9Q0c2CbwbB17Ri/v3i/33HcelMjzA93zA50/tCEBDaAPXK5cx8AQ6LmO/VkIe35wAVwBRsmgGOi4jn27Bnt+cAiEZfZqhsFXkiCEeAGs3IGS1ftlYN00OTm22KybAFtAL6/lcLds4u7ONmkqmExnyL1KZvmXNE2j3WqSpoLROEQIkZes/FBZBdqtJjXDYDQOOdjfQ1Ur3N0/kCRJ4UpK9noxQBTNUdUK52enVKsak+mMaD6XmRt55yHAYrnkLfppfl8seXx6Lho4kKNqZFEZUjQyGLqOfbQ22XXsV6CT2/+I40Iw6yn9nnqWY3flVUNg4Dr2Nf9G30hRbm2RmbH4AAAAAElFTkSuQmCC'+
          '") no-repeat scroll transparent; }
          div.user { padding: 0; margin: 0; width: 15px; height: 15px; background: url("'+
          'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABMAAAAVCAYAAACkCdXRAAAABGdBTUEAALGPC/xhBQAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9wGDhYKBs2QZhoAAANZSURBVDjLrZNdaJtVHMafc97PfL5J06Y1bTdWuzrGqENYhbXsxmnZpjdeKLuYOBQVERmI7GIXejNEL7wQHAje+TGmlN2piOIUnfjRWtjUZenSLTVhSZcmeZM3eT/OhxcNCiXtKvjAn8N5DvzO/+H8D0EP/Xj+NbpaK+0vFrxTsWjsQDI10DDj4fPcb3/wyMnX17CJyEbj8odnidN2pnNL+TnOkc4Mj2Jkxy4IAM1a5X0vCF557MWzdi+YutHILt1KSCGeN0PxtG4aaNg29EoZhmGgYbdOEko/A3BxW7DA9waikdDMkUePQomkkM8XQFUVViyM7OKvSmHl5t5twyb2TGjV1YpmmCYUM4z7D0wBVAUoILw2nJaduPDmy8aTp9/x7gqLRSP9ffGdGS4kBAvAWi0QRYUKiVg0jIndY8NBwCIA7g5LJvrqukYqUgSDREoQCEAwMCmgKpInB0LznIhGr5h0o+Fz/On45A3iNwHWBpgLsA7gNaFrWExkcHF06lm+Ldieh5/yozqdE4F/VTir4O4apNdA0CyjXCzNLf1RXd5szmgvkxvW7TXX/LhdvwPVs6F4dRSLfzkLv+QWJmdflf8JtmPqGAu0xLVKhyJ3s4hrN26hI6wSH9HvYAvRzQ4yydRo39Be5MttrKwJjO+c7E/tsuJbwZSNxgvnHppJHXFODYTw9P7EeNKrM2TiSShWJfTpyoX7xKG6Oj6bKi1/0Wxt+jcPn9n3ePJe/XipXnjARm2szzQw3b8Pg3QQlHBc9W7gp1oWQpKmCTPnC3exn2be/eql4sI/sAePnaZDh+ZPLHvfv8UjbpqoACEAJwCRgKmpkFLCZRwKARQCQAJSAIam50M/HDz+7UeXfgYAygMSLrPfzzDTTWsKoCmASgCDrE+0FzD4jEPr7olcj0MlYHv+mDWpPnPu0lwIAGj6YO6wQ27vpqLbq/x3pQTQutXrpUgAVM3fnhgaGx4BAMpC2ef8LkFIQPL1CFJuXUKsX1Jl1cSXX783CwDUKZjfmG5ilQQEggEcgOg22AvCJcA4wBggfRVxe/D6/OfZLACohGtv31M++knHqs8wtzRNFHvCg5Nmwg1zIVTBBQEASqlUqOob1GzqsEqmF7/id6zvUItcdtxaC/+3/gb4+o+7JYRYDwAAAABJRU5ErkJggg%3D%3D'+
          '") no-repeat scroll transparent; }
          div.legend { border: 1px solid #666; color: #333; font-size: 10px; padding: 5px; overflow: auto; width: 510px; margin: 0 auto; }
          div.legend > div { margin: 0 auto; } 
          div.legend > div > div { float: left; margin: 5px; }
          li.test-title { padding-top: 10px; }
          li.test-title div.icon { background: none; margin: 10px 0 5px -20px; }
          li.test-title h3 { color: #3399CC; }
          li { overflow: auto; }
          li div { float: left; padding: 5px; }
          div.test-step { width: 680px; }
          div.test-step h3 { margin: 0 10px 0 0; float: left; }
          div.test-result { width: 20px; }
          .timestamp { color: #333; font: 11px courier, sans-serif, sans}
          .title { font-family: verdana; font-size: 30px;  font-weight: bold; text-align: center; color: black;}
          .bold_text { font-family: verdana; font-size: 12px;  font-weight: bold;}
          .normal_text { font-family: verdana; font-size: 12px;  font-weight: normal;}
          .small_text { font-family: verdana; font-size: 11px;  font-weight: normal; text-align: center; padding-top: 15px; }
          .border { border: 1px solid #ccc;}
          .question { font-family: verdana; font-size: 12px;  font-weight: normal; text-align: center;}
          .result_ok { font-family: verdana; font-size: 12px;  font-weight: bold; text-align: center; color: green;}
          .result_nok { font-family: verdana; font-size: 12px;  font-weight: bold; text-align: center; color: red;}
          .match { font-family: verdana; font-size: 12px;  font-weight: bold; text-align: center; color: green;}
          .nomatch { font-family: verdana; font-size: 12px;  font-weight: bold; text-align: center; color: orange;}
          .overall_ok { font-family: verdana; font-size: 12px;  font-weight: bold; text-align: left; color: green;}
          .overall_nok { font-family: verdana; font-size: 12px;  font-weight: bold; text-align: left; color: red;}
          table.results { border: 1px solid #DEDDDD; }
          table.results th { font-weight: bold; text-align: center; color: black; background-color:#F7F7F7; padding: 5px; }
          table.results td { padding: 3px; border: 1px dotted #DEDDDD;}
          table.results tr:last-child td { background-color:#F7F7F7; height: 5px;}
          table.overall_results tr td {height: 10px;}
          a:link, a:visited { color: #333; text-decoration: none;}
          a:hover { color: #0062A0; /*text-decoration: underline;*/}
          a:active { color: #5895BE; }      
          a > p, a > h3 { margin: 0 10px 0 0; float: left; } '
end