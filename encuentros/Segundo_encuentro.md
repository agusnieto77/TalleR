<style>

@import url('https://fonts.googleapis.com/css2?family=Vollkorn&display=swap');

.toc-content {
    padding-left: 30px;
    padding-right: 40px;
    margin-top: 20px;
}

div.blue pre { background-color:pink; }
div.blue pre.r { background-color:lightblue; }

.hljs-comment {color: darkred; font-size: 12pt;}

.hljs-string {color: darkred; font-size: 12pt;}

pre {
    display: block;
    padding: 9.5px;
    margin: 0 0 10px;
    font-size: 12pt;
    line-height: 1.42857143;
    color: #333;
    word-break: break-all;
    word-wrap: break-word;
    background-color: #f5f5f5;
    border: 1px solid #ccc;
    border-radius: 4px;
}

body {text-align: justify; font-family: Vollkorn;}

p {font-size: 18px;}

  
ul {
  position: relative;
  list-style: none;
  font-size: 18px;
}

li::before {
  content: '👉  ';
  position: absolute;
  left: 0px;
}

div#TOC li::before {
  content: '';
  position: absolute;
  left: 0px;
}

div.btn-group.pull-right.open li::before {
  content: '';
  position: absolute;
  left: 0px;
}

h1.title {font-size: 38px; text-align: center; margin-top: 0px;}

h3.subtitle {font-size: 26px; text-align: center; margin-bottom: 20px; margin-top: 0px;}

h4.author {font-size: 16px; text-align: center; margin-top: 0px;}

h4.date {font-size: 14px; text-align: center; margin-bottom: 0px; margin-top: 10px;}

p.abstract {color: transparent; font-size:0px;}

b, strong {font-size:19px;font-weight: 700;}

tbody.argumentos {
    display: block;
    vertical-align: top;
    border-color: inherit;
    margin-left: 30px;
}

tr.argumentos {
    display: table-row;
    vertical-align: inherit;
    border-color: inherit;
}

h4 {
    font-size: 21px;
    font-weight: bold;
    color:  darkred;
    font-weight: 700;
}

h5 {
    font-size: 19px;
    font-weight: bold;
    color: darkblue;
    font-weight: 700;
}

#wrap {
  width: 1000px;
  height: 1100px;
  padding: 0;
  overflow: hidden;
  margin-bottom: -190px;
}

#scaled-frame {
  width: 1000px;
  height: 1100px;
  border: 0px;
}

#scaled-frame {
  zoom: 0.8;
  -moz-transform: scale(0.8);
  -moz-transform-origin: 0 0;
  -o-transform: scale(0.8);
  -o-transform-origin: 0 0;
  -webkit-transform: scale(0.8);
  -webkit-transform-origin: 0 0;
}

@media screen and (-webkit-min-device-pixel-ratio:0) {
  #scaled-frame {
    zoom: 1;
  }
}

#TOC {
    margin: 20px 0px 20px 0px;
}


</style>

<br>

# Intro a `rvest`

<br>

## Funciones de `rvest`

<br>
