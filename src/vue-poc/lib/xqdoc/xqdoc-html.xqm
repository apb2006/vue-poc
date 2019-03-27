(:~
 : Generate XQuery  documentation in html
 : using file:///C:/Users/andy/workspace/app-doc/src/doc/data/doc/models
 : $efolder:="file:///C:/Users/andy/workspace/app-doc/src/doc/data/doc/models"
 : $target:="file:///C:/Users/andy/workspace/app-doc/src/doc/generated/models.xqm"
 :)
module namespace xqhtml = 'quodatum:build.xqdoc-html';

declare namespace c="http://www.w3.org/ns/xproc-step";
declare namespace xqdoc="http://www.xqdoc.org/1.0";

(:~ transform files to html
 : @param $params  keys: resources 
 : "ext-id": "299",
 : "src-folder": "C:/Users/andy/git/vue-poc/src/vue-poc",
 : "project": "vue-poc"
 :)
declare function xqhtml:index-html($files,
                            $params as map(*)
                            )
as document-node()                            
{
let $d:=<div>
             <h1>
                  <span class="tag tag-success">
                      { $params?project }
                  </span>
                  XQDoc ,id: { $params?ext-id }
              </h1>
              { xqhtml:toc($params) }
              <a href="restxq.html">RestXQ</a>
              <div>src: { $params?src-folder }</div>
              <div id="file">
                  <h1>Files</h1>
                  <ul>
                      { for $file  at $pos in $files//c:file
                      let $ip:= $file/@name/resolve-uri(.,base-uri($file))
                      let $path:= string-join($file/ancestor-or-self::*/@name,'/') 
                      return  <li>
                                <a href="modules/F{ $pos }/index.html">
                                   { $file/@name/string() }
                                </a>
                    
                                { $pos }
                                { $ip }
                            </li>
                      }
                  </ul>
              </div>

              <div id="ns">
                  <h1>Namespace</h1>
                  <ul>
                      <for-each select=".//c:file">
                          <variable name="path" select="resolve-uri(@name,$src-folder)"/>
                          <variable name="doc" select="doc($path)"/>
                          <li>
                              <value-of select="position()"/>
                              <value-of select="$path"/>
                          </li>
                      </for-each>
                  </ul>
              </div>
           </div>
let $params:= map:merge(($params,map:entry("resources","resources/")))
return document{ xqhtml:page($d, $params ) }
};

declare function xqhtml:toc($params)
as element()
{
    <nav id="toc">
            <h2>
                <a id="contents"></a>
                <span class="tag tag-success">
                    { $params?project }
                </span>
            </h2>
            <ol class="toc">
                <li>
                    <a href="#main">
                        <span class="secno">1 </span>
                        <span class="content">Introduction</span>
                    </a>
                </li>
                <li>
                    <a href="#ns">
                        <span class="secno">2 </span>
                        <span class="content">Namespaces</span>
                    </a>
                </li>
                <li>
                    <a href="#file">
                        <span class="secno">3 </span>
                        <span class="content">Files</span>
                    </a>
                </li>
            </ol>
        </nav>
};

(:~ 
 : generate standard page wrapper
  :)
declare function xqhtml:page($body,$opts as map(*)) 
as element(html)
{
    <html>
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta http-equiv="Generator" content="xqdoc-r - https://github.com/quodatum/xqdoc-r" />

        <title>
          RestXQ - xqDoc
        </title>
        <link rel="shortcut icon" type="image/x-icon" href="{$opts?resources}xqdoc.png" />
        <link rel="stylesheet" type="text/css" href="{$opts?resources}page.css" />
        <link rel="stylesheet" type="text/css" href="{$opts?resources}query.css" />
        <link rel="stylesheet" type="text/css" href="{$opts?resources}base.css" />

      </head>

      <body class="home" id="top">
        <div id="main">
        {$body}
        </div>
        <div class="footer">
            <p style="text-align:right">generated at {current-dateTime()}</p>
          </div>
      </body>
    </html>
};

    