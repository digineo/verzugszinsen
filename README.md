Verzugszinsrechner
==================


Beispiel
--------

Argumente:

* Ausgangsforderung
* Zeitraum
* Prozentpunkte über dem Basiszinssatz (siehe `lib/basiszinssatz.yml`)

```
puts Verzugszinsen.new(1500, (Date.parse '2009-09-15')..(Date.parse '2012-02-17'), 8).inspect
```

Ausgabe:

```
Zeitraum                  | Tage | Zinssatz | Zinsertrag
--------------------------------------------------------
2009-09-15 bis 2009-12-31 |  108 |     8.12 |    36.0395
2010-01-01 bis 2010-06-30 |  181 |     8.12 |    60.3995
2010-07-01 bis 2010-12-31 |  184 |     8.12 |    61.4005
2011-01-01 bis 2011-06-30 |  181 |     8.12 |    60.3995
2011-07-01 bis 2011-12-31 |  184 |     8.37 |    63.2910
2012-01-01 bis 2012-02-17 |   48 |     8.12 |    15.9738
--------------------------------------------------------
Ausgangsforderung:    1500.00
Zinsen Gesamt:         297.50
Gesamtforderung:      1797.50
```


Credits
-------

Copyright (c) 2013 Digineo GmbH, Germany
