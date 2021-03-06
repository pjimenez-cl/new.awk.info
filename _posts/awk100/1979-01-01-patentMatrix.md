---
layout: default
title: "PatentMatrix: survey gene/protein patents"
tags: [awk100, patents]
permalink: /awk100/patentMatrix.html
---

# {{ page.title }}

(*From Source Code Biol Med. 2007 Sep 6;2:4. by A. Lahm, E. de Rinaldis*)

BACKGROUND: The number of patents associated with genes and proteins and
the amount of information contained in each patent often present a real
obstacle to the rapid evaluation of the novelty of findings associated
to genes from an intellectual property (IP) perspective. This assessment,
normally carried out by expert patent professionals, can therefore become
cumbersome and time consuming.  Here we present PatentMatrix, a novel
software tool for the automated analysis of patent sequence text entries.

METHODS AND RESULTS: PatentMatrix is written in the Awk language and
requires installation of the Derwent GENESEQtrade mark patent sequence
database under the sequence retrieval system SRS.The software works
by taking as input two files: i) a list of genes or proteins with the
associated GENESEQtrade mark patent sequence accession numbers ii) a list
of keywords describing the research context of interest (e.g. 'lung',
'cancer', 'therapeutics', 'diagnostics'). The GENESEQtrade mark database
is interrogated through the SRS system and each patent entry of interest
is screened for the occurrence of user-defined keywords. Moreover,
the software extracts the basic information useful for a preliminary
assessment of the IP coverage of each patent from the GENESEQtrade mark
database. As output, two tab-delimited files are generated which provide
the user with a detailed and an aggregated view of the results.An example
is given where the IP position of five genes is evaluated in the context
of 'development of antibodies for cancer treatment'.

CONCLUSION: PatentMatrix allows a rapid survey of patents associated
with genes or proteins in a particular area of interest as defined by
keywords. It can be efficiently used to evaluate the IP-related novelty
of scientific findings and to rank genes or proteins according to their
IP position.
