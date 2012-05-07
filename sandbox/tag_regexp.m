% sandbox to create a generic regular expression for markup in publishing
% m-files to a blog. `:tag: data`

%line = 'blah `:download: file-to-download` test text. `:image: file.png`, also see `:postid: 456`';

%matches = regexp(line,'`:(?<tag>\w*):\s*(?<data>[a-zA-Z\s\-_\.]*)`','names')

%[tokens matches] = regexp(line,'`:download:\s?([a-zA-Z0-9\s\-_\.]*)\s?`','tokens','match')

%[tokens matches] = regexp(line,'`:image:\s?(?<data>[a-zA-Z0-9\s\-_\.]*)`\s?','names','match')

%[tokens matches] = regexp(line,'`:postid:\s?(?<data>[0-9]*)\s?`','names','match')

clc
line = '<img src="first_order_reversible_batch_eq69370.png" alt="$A \rightleftharpoons B$"></p><p>forward rate law: <img src="first_order_reversible_batch_eq43780.png" alt="$-r_a = k_1 C_A$"></p><p>backward rate law: <img src="first_order_reversible_batch_eq71205.png" alt="$-r_b = k_{-1} C_B$"></p><p>this example illustrates a set of coupled first order ODES</p><pre class="codeinput"><span class="keyword">function</span>'
[tokens, matches] = regexp(line,'<img src="(.*png)"[^>]*>','tokens','match')
[tokens, matches] = regexp(line,'(?<=img\s+src\=[\x27\x22])(?<Url>[^\x27\x22]*)(?=[\x27\x22])','tokens','match')

char(matches)