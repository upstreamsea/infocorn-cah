<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>The DEF CON CAH Server</title>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>
  <header class="p-3 bg-dark text-white">
    <div class="container">
      <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
        <a href="/" class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none">
          The DEF CON Cards Against Humanity Server
        </a>
        <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
        </ul>
        <div class="text-end">
          <button type="button" class="btn btn-warning" onclick="window.location='game.jsp';">Let's Play!</button>
        </div>
      </div>
    </div>
  </header>

  <main class="flex-shrink-0">
  </br></br>
    <div class="container">
        <div class="col">
            <div class="card">
              <div class="card-body">
                <h5 class="card-title">Known Issues</h5>
              </div>
              <ul class="list-group list-group-flush">
                <li class="list-group-item"><strong>Do not open the game more than once in the same browser.</strong> Neither instance will receive all data from the server, and you will not be able to play. I have an idea on how to fix this, but I haven't had time to do so.</li>
                <li class="list-group-item">This game was extensively tested in <a href="http://google.com/chrome">Google Chrome</a>. It should work in all recent versions of major browsers, but it may not look 100% as intended. If you find a major issue, please <a href="https://github.com/ajanata/PretendYoureXyzzy/issues/new">open a bug on GitHub</a> with a screenshot and the name and version of the browser you are using, and I'll try to fix it.</li>
                <li class="list-group-item">You may not always see your card in the top area after you play it, but it has been played. Also, sometimes the card will display in the top area but be small. I have no idea why either of these happen.</li>
                <li class="list-group-item">If you refresh in the game, an error will pop up in the log briefly before the refresh happens. It is safe to ignore.</li>
                <li class="list-group-item">You may see an error after joining a game. As the error message states, this is safe to ignore. I will figure out a way to make this not show up.</li>
                <li class="list-group-item">Interface elements may not be perfectly sized and positioned immediately after loading the page if your window is sufficiently small. Resize the window to fix.</li>
                <li class="list-group-item">A player joining the game in progress may have a slightly incorrect representation of the game state until the next round begins.</li>
                <li class="list-group-item">Reloading the page when the winning card is displayed does not display the winning card again.</li>
                <li class="list-group-item">Played cards seem to blank when someone joins or leaves. You may have to refresh the page to see the cards again if you're the Card Czar.</li>
              </ul>
            </div>
          </div>
    </div>
  </main>
</br></br>
  <footer class="footer mt-auto py-3 bg-light">
    <div class="container">
      <span class="text-muted">The DEF CON CAH Server is a Cards Against Humanity clone, which is available at
        <a href="http://www.cardsagainsthumanity.com/">cardsagainsthumanity.com</a>, where you can buy it
        or download and print it out yourself. It is distributed under a
        <a href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative Commons - Attribution -
        Noncommercial - Share Alike license</a>. This web version is in no way endorsed or sponsored by
        cardsagainsthumanity.com. You may download the source code to this version from
        <a href="https://github.com/ajanata/PretendYoureXyzzy">GitHub</a>. For full license
        information, including information about included libraries, see the
        <a href="license.html">full license information</a>.</span>
    </div>
  </footer>
<p>
</p>
</body>
</html>