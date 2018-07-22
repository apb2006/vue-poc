<?xml version="1.0" encoding="UTF-8"?>
<!-- 
	Schematron to test compliance with DocBook derived specifications beyond the levels that
	can be tested with validation against the RelaxNG schema
	
    Copyright 2013 Brad Scott, Brambletye Publishing
    brad.scott@brambletye-publishing.co.uk

    drawing on earlier portions:

	Copyright 2007-2010 Nic Gibson and Corbas Consulting Ltd
	Copyright 2009-2010 Stuart Brown and Oxford ML

    The DocBook Schematron from http://www.docbook.org/xml/5.0/sch/ has also been incorporated, and lightly modified
	
	Permission to use, copy, modify and distribute this schema
	and its accompanying documentation for any purpose and without fee
	is hereby granted in perpetuity, provided that the above copyright
	notice and this paragraph appear in all copies. The copyright
	holders make no representation about the suitability of the schema
	for any purpose. It is provided "as is" without expressed or implied
	warranty.
	
	This is intended to be used with an ISO schematron processor.

Revisions
=========

    20170602 [AS]
        Allowing person/@xlink:role (re Encyclopedia of Philosophers)
    20170511 [AS]
        Added pattern bibliolists-in-bibliodiv, mandating bibliolist within bibliodiv.
    20170413 [AS]
        Added series title 'Aircraft of the Aces'
    20170411 [AS]
        Fixed bug in hebrew-context and arabic-context: should be parent 
        instead of self axis.
        pi-markup: allowing ampersand in insert PI, as this may be legitimate (see
        portal query 000165).
        Added ampersand-in-pi-insert to disallow probable character reference
        in insert PI.
    20170403 [AS]
        Removed spurious series titles: The Early Novels, The Dream Colony,
        A Court of Wings and Ruin
    20170330 [AS]
        Added series title "The Dream Colony"
        All patterns, rules, asserts and reports now have an ID.
    20170327 [AS]
        Added series title "A Court of Wings and Ruin"
    20170322 [AS]
        Added series title "Crossing Ebenezer Creek"
    20170320 [AS]
        Added series title "A Good Country"
        Allowing DOI for section[@role='subArticle'] (for SSP reference content type)
        Allowing @outputformat for pubdate: SSP requires an online-only pubdate
    20170221 [AS]
        Added series title "The Early Novels"
    20170126 [AS]
        Removed dedication from front-context-3
        Added dedication (as a warning now) to front-context-4
        Added book-level-dedication
    20170119 [AS]
        Added series title "Hart Studies in European Criminal Law"
    20161221 [AS] 
        Added series title "Hart Studies in Security and Justice"
    20161116 [AS]
        Added "Unicorn Princesses" series name
    20160930 [BS]
        Made email-test-2 a warning, and re-worded the error message
    20160823 [BS]
        Tweaked non-docbook-ns so MML content is permitted
    20160802 [BS]
        Made tests in lineage-context warnings since it is a bit overzealous
        Added dissertation-context to catch some instances of incorrect markup
        Removed pattern uri2 since it was redundant, and improved para-link-context to remove false positives
        Added uri-in-link to ensure uris are in links
    20160722 [BS]
        Added the following for annotated legislation volumes: jurisdiction-required; legislation-required; jurisdiction-values; jurisdiction-location; legislation-divisions; legislation-divisions-location; legislation-chapter; legislation-section; legislation-label; legislation-ids; legal-section-ids1; legal-section-ids2; legal-section-ids3; leg-note; leg-case; bridgehead-annotations
        Modified chunk-id-context to accommodate legislation chapters having non-standard IDs
        Modified all-id-context to exempt legislation chapters requiring non-standard IDS
    20160721 [BS]
        non-permitted-otherclass: added legalJurisdiction + legalDivType as a new permitted values
        case-name-location: permitted in legislation books as well
    20160720 [BS]
        Added support for annotated legislation:
        note-cases: notes also permissible in legislation volumes
    20160706 [AS]
        singleton-imageobject: only one imageobject in a mediaobject (for web output)
        changed schema version to '5'
        other-namespace: fixed bug; now using namespace-uri()
    20160707 [BS]
        Added support for legal cases. Allowed <note> within this instance of DocBook, and that it can take @role. Added series name to series-name-list, and refactored code. Removed x3, so allow notes in notes. bridgehead-location and proportion-case-legislation do not apply to case reports.
        decision-date: must be an ISO date
        case-biblioid-location: can only occur in chapters
        reworked: first-last-1; list-para-test, to remove false positives
        Modified footnote-context-2 so doesn't apply to legal books; too many false positives
        Added case-name-location: the caseNamemphrase can only occur in case reports
        + case-pi, case-title-phrase, for additional tests on phrase in a case report title
        Modified chunk-doi-context2 and doi-not-required to be a bit more flexible with locations for DOIs in old BFL books
    20160704 [BS]
        Added constraint in legal-contents-context2 so that only applies where there is a descendant variablelist
    20160425 [BS]
        bridgehead-renderas, bridgehead-role [use the default DocBook support for bridgehead rendering control]
    20160414 [BS]
        imo-title, imo-present: inlinemediaobjects in a title are unlikely to be right; and add info if any are present at all
        spaces-label: @label must not contain only space characters
    20160405 [BS]
        pi-markup: processing instructions mustn't contain ampersands or pointy brackets
    20160316 [BS]
        chunk-colon: it is an error for a chunk title to end with a colon
        added 'Parliamentary Democracy in Europe' as a valid series title
        Reworked name-context-4 and added name-initials-1, info-bibliotype-context: to accommodate different initial style in bibliographies between chapters
    20160226 [BS]
        label-required2 ensures that, if there is a @role=labelOverRide then there is also a @label
    20160218 [BS]
        Minor amendments to bibliomixed-successive-contributors, bibliomixed-publishername-space, bibliomixed-address-space, uri-check to reduce false positives
    20160217 [BS]
        Corrected trivial error in break-type
    20160216 [BS]
        For all new books schematronVersion = 5 is REQUIRED
        Added notes-pi-title to catch other instances where PIs and titles conflict
        Added break-typology and break-type for more rigour in PI testing
        Added object-target-id, object-in-para, object-in-blockquote for further tests on image/table/sidebar placement
    20160201 [BS]
        Added end-ch-notes-title to ensure that end-ch-note PIs in sections don't contain title
    20160129 [BS]
        Added constraint on doi-eonly-context so it does not apply for old DOIs (beginning with 10.2752)
    20160127 [BS]
        all-id-test [to ensure all IDs start with book ID], and schematronVersion MUST now be set to 5
    20160122 [BS]
        object-role, object-href, object-id, anchor-id, anchor-role [tests to support pointers to image/table objects etc]
    20160120 [BS]
        footnote-link [footnote in link is not permitted]
    20160118 [BS]
        DOInotRequired-test, chunk-doi-not-required and other related tweaks to enable not having chunk DOIs in rare cases 
    20160104 [BS]
        minor amendment to legal-preface
    20151221 [BS]
        Minor modification to poss-recording, poss-film
    20151215 [BS]
        Modified beginning-context so does not apply to e-Only books
    20151214 [BS]
        Added bib-bracks-1 and bib-bracks-2 to catch unbalanced brackets in some bibliomixed content
        And bib-sqbracks-1 and sqbib-bracks-2, and bib-quote-1 and bib-quote-2
        orgname-emphasis, since an orgname with emph in it is rather odd
    20151210 [BS]
        legal-lists: orderedlists are not permitted in legal texts; variablelist must be used with labels captured as <term>s
    20151209 [BS]
        poss-recording, poss-film for new bibliomixed types
        artist-required, recording-title, film-title, recording-date, film-date
    20151208 [BS]
        taxon-name-punc, taxon-name-content: improved reporting for natural history markup, reduced false positives
        smallcaps-test, in case only contains caps
    20151202 [BS]
        Modified pub-address-missing and pub-city-missing
        Added imprint-published, copyright-year, holder-act, holder-year, dupe-isbns, isbn-role, lawstatedate-missing, content-required, non-inline-bibliolist
    20151126 [BS}
        Modified suppress-pdf-required to remove false positives with parts
        Added page-breaks-present, since books that are e-Only (ie with no strict print equivalent) must not have page break PIs
    20151124 [BS]
        Reduced number of false positives in para-lower-case
        Added link2016 and reduced false positives in it and related tests
        Added untagged-url2 for additional cases where there are untagged URLs
    20151123 [BS]
        Added companion-location to enforce location of a Companion Website block in book/info, and companion-flag to esure hasOnlineResources is present and has corret value
    20151191 [BS]
        Add specialBookType-test which is a new flag for biblioid
    20151118 [BS]
        Adjusted front-back-only so allows article as direct child of book
        Removed false positives in para-lower-case triggered by indexterm
        Made single-page an error not a warning
    20151110 [BS]
        legal-type-check, ensures Hart and Bloomsbury Professional titles have legalContentType set
    20151102 [BS]
        resource-required, label-required [extra attributes required on ISBN biblioid for other volumes]
    20151029 [BS]
        end-para-notes-item [checks syntax of end-para-note PI]
        para-insert-missing [ensures end-para-notes PI is present where necessary]
        end-para-note-footnote [ensures end-para-note footnotes are present if there is a relevant PI]
    20151009 [BS]
        link can now take @xlink:role [xlink-role-context - to support links to OAO etc]
    20151007 [BS]
        pub-city-missing and pub-city-content added to ensure there is a publisher city for the purposes of citations
        upper-case-imprint and upper-case-publishername added for more rigour in citations
    20151006 [BS]
        pub-address-missing and pub-address-location added to enforce more rigour on publisher address
    20150926 [BS]
        pn-context-1 and pn-context-2 no longer apply to <article>s since they produce too many false positives
        improved sensitivity of see-context
        article-xref-2 [warns if articles have multiple paras and marked as @role=xref]
        bridgehead-location [bridgehead is not allowed as a child of a chunk element or a section, ie where it should be divided up using section]
        index-component-test [index terms must not end with a colon]
        abstract-error [book blurbs don't contain a title]
    20150919 [BS]
        Added series-location to get better precision for placement of series name
    20150813 [BS]
        Removed A Scholar's View from fpa-typology, since it is incorrect
    20150716 [BS]
        More tests for very structured natural history content [taxon-parent, class-parent, subclass-parent, supercohort-parent, cohort-parent, superorder-parent, order-parent, suborder-parent, hyporder-parent, infraorder-parent, parvorder-parent, superfamily-parent, family-parent, subfamily-parent, tribe-parent, genus-parent, subgenus-parent, species-parent, taxon-chapter, sibling-taxon, sibling-taxon2]
        Added olink-targets to ensure olink target IDs match the target book ID
        Fixed another error for Geographers series name
    20150707 [BS]
        added bedArticleType-test to support Bloomsbury Encyclopedia of Design article classification
    20150701 [BS]
        added legalContentType as value of biblioid/@otherclass [bibid-other-context]
        legalContentType-test to enforce permitted values
    20150619 [BS]
        Fixed the incorrect error for Geographers series name
    20150617 [BS]
        fpa-article-type, fpa-typology, invalid-fpa [Further constraints for FPA articles]
    20150519 [BS]
        taxon-rank-check [Additional test for biology-specific data]
    20150515 [BS]
        fpa-keywords , fpa-glossary, fpa-mediaobject [specific tests for the Fashion Photography Archive]
        added taxonRank as value of biblioid/@otherclass [bibid-other-context]
        Added taxonRank-test with defined list of taxon ranks
        Added taxon-siblings
    20150501 [BS]
        invalid-pi [error if invalid processing instruction type]
        insufficient-isbns [There must be at least one other ISBN than the XML ISBN]
        loc-cip2 [BL and LoC CIP data must not be in the same legalnotice]
        insert-pi-title, insert-pi-title2 [warns if insert PI title looks incorrect]
        bibliomixed-other-issue2 [a bibliomixed/other shouldn't have volumenum etc in it]
    20150430 [BS]
        Reduced false positives in surname-context
    20150422 [BS]
        stop-firstname and comma-firstname [punctuation not allowed in firstname]
        ends-with-comma [comma not allowed at end of several other biblio elements]
        bibliomixed-other-issue1 [a bibliomixed/other shouldn't have publishername etc in it]
        pubname-in-article [warns if likely wrong biblio item type]
        trans-not-au, trans-not-ed, ed-not-au [warns if possible incorrect name markup]
        book-not-journal [likely book marked up as a journal]
    20150421 [BS]
        page-no-match1 and page-no-match2 [ensures that the values of pagenums and the first and last page break PI have the same values]
        only-blockquote-content-article, contrib-statement-present-article, full-text-extract-article, article-editor-present, date-in-article-info, possible-epigraph-article [versions of some of the chunk content tests, adapted for articles]
    20150409 [BS]
        series-name-list [checks if the series name exactly matches one of the Bloomsbury series; this list will have to be added to when new series are added to Biblio]
        poss-line-number [warns if a poetry line has an untagged number at start or end in case it should be a line number]
        abstract-indexterm [indexterms are not allowed in abstracts, to avoid mis-placement of body text indexterms]
        Added entities &precedingPageNoVariable; and &pageNoAndChunkPDF; to enable more precise reporting of corresponding page number and pdf for comparison with the markup. The former is used below to add a <let/> and the latter inserts the name of the source pdf and page number into a report or assertion.
    20150313 [BS]
        For all new books schematronVersion = 4 is REQUIRED
        doi-not-req, pagenums-not-req, mediaobject-not-req [Ensures that DOI, pagenums and mediaobject don't appear in info blocks other than in chunks etc]
        part-label-context-3, chapter-label-context, appendix-label-context [Some @labels must not begin with specific words, ever]
        enforce-id-1 through enforce-id-8 [chapter, part, appendix and formal para must have predictable IDs, when schematronVersion=4]
        formalpara-title must only contain alphanumeric characters and full stops if formalparaNumeric
        formalpara-title2 warns if formalpara titles contain only numbers and full stops and is not formalparaNumeric
        drama-poetry-parent warns if these elements are not in a blockquote since they normally should be
        line-attribution warns if text at the end of a line looks suspiciously like an attribution
        para-lower-case warns if para starts with lower case (apart from when in lists etc)
        possible-missing-space4 warns if inline bibliolist is not preceded by a space
    20150310 [BS]
        Added no-series, which warns if there is no series metadata for non-fiction books, since a very high proportion of academic books should be in a series
        Added publisher-address, since addresses in book/info are almost certainly publisher addresses
    20150309 [BS]
        Modified non-permitted-otherclass, bibl-count-context and bibl-context-3 to allow linked bibl tests to be switched off if allBiblioItemsUnlinked
    20150213 [BS]
        Added geog-title, geog-title2, geog-volnum, geog-volnum2, geog-volnum3 [Fine-scaled checking for the Geographers Biobibliographical series]
    20150206 [BS]
        Added pubdate to elements that can take @condition [elements-with-condition]
    20150129 [BS]
        schematron-version-test now allows a value of '3'
        chunk-id and chunk-id2 ensure that chunk IDs MUST start with the book/@xml:id
        schematron-version-info adds the schematronVersion value to the info output
    20150107 [BS]
        Fixed see-context so there is no divide by zero error
    20141203 [BS]
        Reworked footnote-para, and added footnote-para-2
    20141104 [BS]
        Added more restrictions on only-contains-nbsp        
    20141029 [BS]
        Removed restriction on figures occurring within footnotes
    20141024 [BS]
        Added dedication to remark-error
    20141022 [BS]
        legal-contents, legal-toc, legal-preface, legal-contents-links [for tables of cases and statutes in legal texts]
    20141021 [BS]
        Add remark-error [ensures that remark elements can't occur other than as children of chunk elements]
    20141016 [BS]
        Changed alt-required from an error to a warning, since some of them are unresolvable
    20141010 [BS]
        Added snapshot-article, sub-article [to add info message if they are present]
    20140923 [BS]
        Added isbn-check [checksum test for all ISBNs]
    20140910 [BS]
        Allowed anchor element, since there are occasions when it could be useful.
    20140905 [BS]
        Fixed name-context-4 so it actually works now, ie accommodates default situation when there is no biblioType value at all
    20140904 [BS]
        Fixed only-contains-nbsp so it now works again
        label-end-stop [error if @label ends with a stop]
        Allowed 'biblioType' to non-permitted-otherclasss
        More specificity to tests for initials in biblio references, so can support books with a style that does not include stops in initials. So, name-context-4 and name-context-5 are now more specific, and there are new tests: biblioType-test; firstname-one-char-2; firstname-stop-3; firstname-stop-4
    20140715 [BS]
        allowed step and procedure [required for some practical textbooks]
    20140704 [BS]
        article-element-type [components that should only be in an <article>]
        subarticle-test [a subArticle should normally only be in an article, but chapter or section may be OK sometimes...]
        article-xlink-label [restrict when @xlink:label can occur and its contents]
    20140623 [BS]
        Added note to list of disallowed elements
    20140619 [BS]
            Allowed @outputformat on article
            Moved article-pagenums to a new, different context [so can have articles without pagenums]
            Moved doi-context-3 to new context [so does not enforce DOI format check when file is a loose article]
            Allowed @role on keywordset and bibliography [useful for reference works]
    20140531 [BS]
            Added default value to hasOnlineResources-test
    20140520 [BS]
            revhistory-location, revision-sequence, revisions-date-format, revision-author, revision-revremark [tests for revision history and components]
            no-rights-info [info that a content component does not have digital rights]
            no-rights-pdf [warn if a pdf does not have digital rights]
            test-linkend-attribute [@linkend only allowed on link and section]
            article-section-role [a section containing biblio items in an article must have @role=bibliography]
            source-in-caption [items marked as a source can only be in a caption]
    20140519 [BS]
            Made toc-present a warning
            Allowed informalfigure to be the target of a link[@role=figure] [modified link-target-figure]
    20140509 [BS]
            Restructured some of the index tests (created index-1a pattern to contain existing tests which might not have been getting triggered)
            Added more specific context to index-type-context
            type-endofrange [error if an indexterm with @class=endofrange has @type]
            index-not-back [index elements need to be in the back matter]
    20140501 [BS]
            Made date-in-info just a warning, since it can be legitimate in some cases
            processing-instruction-issue [error if there is an end-ch-notes PI but not footnotes in the chapter]
    20140422 [BS}
            olink now allowed [for cross references between books]
            olink-targetdoc [olink @targetdoc required]
            olink-targetptr [olink @targetptr required]
            olink-type [olink @type required]
            olink-targetdoc-id1, olink-targetdoc-id2, olink-targetdoc-id3, olink-targetptr-id [olink attribute format tests]
    20140421 [BS]
            allowed @outputformat on phrase, para, mediaobject, appendix, member, part, chapter, section to support print/web textual differences
            extended definition of &chunk_blocks_print; to exclude web/e-Only chunks
            moved role-or-href to a new, more specific rule
            link-role-version [ensures that, if link[@role] present, then schematronVersion |= 1]
            relative-href [if link[@role=relative], then @xlink:href must be present]
            relative-link-dir [targets of relative links must be in one of three directories]
            conformance-required [if link['role=relative] then @conformance is required = MIME type of target]
            conformance-values [enforces @conformance values for link]
            link-conformance-1 through link-conformance-23 [ensure that when external (local) link targets have a particular file extension they have the correct MIME type on @conformance, so we can test that they are what they claim to be]
    20140410 [BS]
            end-ch-notes-item, end-bk-notes-item [ensure there is an item value in the PIs]
    20140404 [BS]
            othercredit-class-required [Missed this on the contributors checking]
            Add ids to all remaining pattern, rule, report and assert elements that didn't have them
    20140331 [BS]
            authorgroup-required-1, authorgroup-required-2, authorgroup-required-3 [requires an authorgroup wrapper for multiple authors/editors and translators]
            chunk-authorgroup-required deleted and replaced by the preceding
    20140319 [BS]
            duplicate-end-bk-notes [error if duplicate identical end bk note PIs]
    20140317 [BS]
            end-ch-note-footnote [additonal test for end-ch-notes]
            missing-processing-instruction
            end-bk-note-footnote [two more tests for integrity of end-book-note processing instructions]
            missing-processing-instruction2 [if end-ch-note footnotes are present, the chunk must contain a corresponding PI]
    20140314 [BS]
            end-bk-notes-target and end-bk-notes-incorrect [checks that the insert PIs have a target ID and that it matches a chunk target]
    20140310 [BS]
            footnote-para [warns if para contains nothing but a footnote]
    20140224 [BS]
            untagged-doi [DOI with no link markup]
            keep-with-next-pagenums and keep-with-next-mediaobject, plus related fixes of other tests [Enable @role=keepWithNext on part divs other than in books with articles]
    20140220 [BS]
            mediaobject-required [figure/informalfigure must contain a mediaobject]
            page-break-format [checks content of page break PI]
            Removed book-honorific-dr since it's not adding much and is broken
    20140214 [BS]
            em-ghost (and related tests) [checks for html hangovers from CDATA from Biblio]
            inline-bibliolist-footnote [inline bibliolists aren't allowed as direct children of footnote]
    20140213 [BS]
            bibliomixed-publishername-space [warn if no space before a publishername in bibliomixed]
            bibliomixed-address-space [same for addresses]
            asterisk-in-name [Some symbols really should never be in a name component]
            asterisk-in-text [Warn for asterisks generally if not in link or centered para]
    20140210a [BS]
            remove-chapter-outline [Chapter Outlines if ToCs are not required in the data]
            possible-abstract [abstracts should be in a <abstract>]
    20140210 [BS]
            Other minor bits of tidying of existing tests
    20140206 [BS]
            page-break-sequence-2 [Ensures values for page break PIs are sequential]
            page-break-pos-1 [Added further places where page break PIs aren't allowed]
            info-after-pb + info-before-pb [page breaks not allowed before or after info]
            pb-in-footnote [pbs not allowed in footnotes]
    20140131 [BS]
            Commented out possible-qandaset, not sure if it is very useful
    20140130 [BS]
            only-contains-nbsp [Spots cheating where elements only contain non-breaking white space]
            commented out most of the capitalisation rules, not sure how useful they are
            element-not-bibliomset [Warns if other elements than bibliomset present in some biblio items]
    20140129 [BS]
            multiple-personblurb [Error if author etc has more than one personblurb]
            honorific-dir ["Dir." etc should prob not be in honorific]
            improved mixed-personname-style so it works and gives for useful information
            epigraph-in-title [warns in case the title needs to have @outputformat=e-Only]
            comment-present [Warns if there is a comment]
            unlinked-bibliomixed-count [If there are unlinked bibl items, useful to know how many + percentage]
            surname-is-firstname [warns if the surname contains string that is usually a first name]
    20140127 [BS]
            Allowed @role on link
            link-role-required [if schematronVersion greater than or equal to 2, then @role is required; to enforce more rigorous link checking]
            role-or-href [links can't have @role and @xlink:href]
            link-target-figure [these ensure the link targets are the correct elements]
            link-target-table
            link-target-bibliomixed
            link-target-xref
            added a new value of '2' to schematron-version-test
            pb-section-title [page break processing instructions not allowed in section titles]
            contributor-in-title [author, editor, othercredit not allowed in title or subtitle, ever]
    20140123 [BS]
            possible-epigraph [first item in chunk is poetry, drama or blockquote; should be epigraph?]
            refactored bibliomset-title to enforce it in some conditions but not others
            removed legal-author [too restrictive and mostly wrong]
    20140120 [BS]
            only-non-web-image [Image only referenced in eps or tiff, but we also need a web version]
            non-web-image-format [eps or tiff has wrong @outputformat]
            colophon-impressions [ensure the impression data is in colophon (if it exists)]
            part-suppress-pdf and part-abstract [more tests around suppressPDF flags and abstracts]
    20140117 [BS]
            short-link-text [flags links in titles which are only one character long, and may need to be superscript]
            role-or-class [A common mistake is to use @role when @class is required. This tests that for othercredit]
    20140114 [BS]
            Improved possible-link-biblio-2 to reduce false positives
            Removed no-access-date which is a duplicate test
            Removed inline-bibliolist-2, which is unnecessary
            Removed footnote-name-order, which is incorrect
    20140110 [BS]
            no-access-date [biblio item contains "retrieved" etc but no date[@role=accessed]]
            removed possible-part-link [not convinced it is that useful]
            reworked possible-see-link to reduce false positives
            no-space-before-title [in case there is a missing space in a bibl item]
            allowed xlink:href and xlink:role on keyword element [to support historic Bloomsbury Open classification IDs]
    20140109 [BS]
            no-space-before-address [Picking up missing spaces etc in biblio items]
            bracket-following-address
            bad-title-content [biblio item titles must not contain editors, authors, pubdates etc]
    20140108 [BS]
            bibliomixed-successive-contributors [reports if no text() after author, editor, othercredit in bibliomixed]
            figure-title-length [if figure title is more than 100 characters long; could be a caption?]
            name-bracket [name followed by a bracket with no space between]
            biblio-message [a message biblio item must not contain certain elements]
            possible-message [check if biblio item contains the word "email"]
    20140103 [BS]
            pagenums-count [ensures there is only one pagenums in a chunk]
            possible-attribution [if the last para in a blockquote or epigraph has @role=right it should probably be an attribution]
    20131221 [BS]
            author-title-space [checks if no space between author|editor and following title in bibliomixed]
    20131220 [BS]
            Fixed syntax error in title-emphasis
    20131219 [BS]
            title-emphasis [warns if book/journal title in biblio item not all in emphasis]
            bibliomixed-name [name components must be within personname]
            Two more A-Z tests:
            article-para-links
            article-xref
            possible-article-link
    20131218 [BS]
            added article support for A-Z content:
            allowed article
            modified suppress-pdf-required to enable parts with articles to have unsuppressed pdfs
            suppress-pdf-article
            part-article-doi
            article-pagenums
            article-doi
            excluded articles from sequential pagenum-tests
            improved page range checking, so single numbers in pagenums no longer generate false positives
            improved case-regularisation so single-letter titles are OK in upper case (eg for A-Z encyclopedias)
            Modified chunk tests to accommodate 'dummy' heads for A-Z works
            keep-with-next
    20131217 [BS]
            possible-missing-space3
    20131213 [BS]
            footnote-name-order
            surname-only
            in-sans-bibliomset
            trans-in-title
            emphasis-comma
            emphasis-stop
            emphasis-colon
            emphasis-semicolon
            emphasis-empty
            emphasis-lsquo
            emphasis-rsquo
            emphasis-ldquo
            emphasis-rdquo
            confgroup-present
            short-biblio
            mono-book
            book-contribution
            part-contribution
            article-article-2
            journal-article
            firstname-one-char
            firstname-stop
            firstname-stop-2
            honorific-start
            honorific-end
    20131210 [BS]
            Allowed @mark='none' in list-mark
    20131204 [BS]
            index-with-terms + allowed indexterms within index
            book-id-start
            book-id-end
            not-cc
            not-open
            bl-cip
            loc-cip
    20131202 [BS]
            re-structured the context for rule bibliography-text-checks-2
    20131128 [BS]
            tightened rules so only glossary as child of book or part are considered chunks
    20131127 [BS]
            untagged-biblio-content
            possible-unpublished-4
    20131126 [BS]
            possible-unpublished-3
            unpublished-publishername
            untagged-month
    20131125 [BS]
            bib-title-start-quote
            bib-title-end-quote
            space-before-bibliomset-required
    20131120 [BS]
            date-in-info
    20131118 [BS]
            sidebar-present
            prelims-subtitle
            name-initials
            lower-case-imprint
    20131115 [BS]
            name-order-info
            possible-legislation
            personblurb-duplicate
    20131114 [BS]
            chapter-numeration-info
            fiction-info
    20131113 [BS]
            uri-spaces
            chapter-numeration-test
            fiction-test
    20131112 [BS]
            suppress-pdf-partintro
            hebrew
            arabic
            foreignphrase-he
            foreignphrase-ar
    20131111 [BS]
            foreignphrase-lang
            rtl-scripts
            non-rtl-scripts
            multiple-othercredits-1
            multiple-othercredits-2
    20131110 [BS]
            para-dedication-pdfonly
    20131108 [BS]
            section-in-label
            section-in-title
            acknowledgements-chunk
            dedication-in-title
    20131107 [BS]
            no-chs-in-part
            suppress-pdf-abstract
            part-doi-required
            part-no-doi
    20131106 [BS]
            only-one-part
            space-firstname
    20131105 [BS]
            poss-front-matter
            personblurb-para
            possible-edited-book
            book-honorific-dr
    20130104 [BS]
            ch-doi-no-label
            part-no-label
            part-filename-no-label
            app-title group of tests
    2013-10-29 [BS]
            replaced continuum-series with 36 more specific previous-series
            improved specificity of poss-footnote-marker and front-back-only
            improved specificity of other tests, and added more series name checks
            Initial revisions for Spark titles (e-Only):
            pagenums-e-only
            restructured content-chunks so some only apply when not e-Only
            allowed @outputformat on book
            restructured other print tests (chunk-doi-print)
            page-breaks-missing-2
            outputformat-e-only
            outputformat-imagedata
    2013-10-28 [BS]
            imprint-bloomsbury-publishing
            continuum-series
            poss-footnote-marker
            contrib-required
            front-back-only
            numbered-chapter-front
            page-1-front
    2013-10-27 [BS]
            imprint-continuum
            imprint-emphasis
            publishername-emphasis
            possible-missing-space2
    2013-10-22 [BS]
            ampersand
            less-than
            greater-than
            numbers as words in @label [one-in-label etc]
            contrib-present
            outputformat-attribute
            outputformat-present
            pdf-only-extract
            possible-missing-space
    2013-10-21 [BS]
            check-title [ie for strings beginning "chapter", ie chapter-in-title etc]
            label-value
    2013-10-10 [BS]
            biblio-id-format
            page-break-pos-3
            edition-role-present
            link-target-title
            surname-with-stop
            possible-unpublished
    2013-10-09 [BS]
            toc-warning
    2013-10-08 [BS]
            Fixed and added: missing-eqn-sibling-1, missing-eqn-sibling-2, missing-infeqn-sibling-1, missing-infeqn-sibling-2, missing-ileqn-sibling-1, missing-ileqn-sibling-2
            Added: pdf-file-extension, png-file-extension, tiff-file-extension, gif-file-extension, jpg-file-extension
            back-matter-title
            title-required
    2013-10-06 [BS]
            modified bibliomixed-address to fix error in Oxygen 15
    2013-10-03 [BS]
            see-seealso-target
            see-in-itermset
            see-mismatch
            possible-notes-section
            end-ch-notes-missing
            end-bk-notes-missing
    2013-10-02 [BS]
            indexterm-location
    2013-10-01 [BS]
            para-before-epigraph
            poetry-drama-present
            dialogue-in-drama
            part-initial
            part-medial
            part-final
            possible-poem
            possible-qandaset
            index-missing
            indexterms-missing
            missing-index-type
            wrong-index-type
            zone-present
            indexterm-class-missing
    2013-09-30 [BS]
            Added the following tests:
            list-para-test
            nested-list
            continuation-present
            numeration-present
            startingnumber-present
            inheritnum-present
            multi-terms
            table-row-col-att
            figure-present
            eqn-present
            missing-eqn-sibling-1
            missing-eqn-sibling-2
            multi-format-eqns
            eqn-condition-required
            math-condition-attribute
    2013-09-26 [BS]
            Added the following tests:
            chunk-authorgroup-required
            chunk-editor-present
            acknowledgements-present
            back-chunk
            columns-present
            line-break-present
            condition-present
            bibliomixed-address
            doi-href
            mixed-personname-style
            other-editions-etc
            jr-present
            sr-present
            ii-present
            iii-present
            iv-present
    2013-09-19 [BS]
            Completed cross refs from data spec to this file, with some minor improvements to existing tests
    2013-09-19 [BS]
            More tidying of file
            Improved page break PI reporting
    2013-09-17 [BS]
            report following-sibling page break PIs
            warn if bibliomixed not referenced in text
    2013-09-16 [BS]
            ensure inline bibliolists have @role
            bibliomixeds that should be articles
            report empty links
            report long link content
            @label starting with words
            report loc cits
            missing alt
            biblioref and xref now an ERROR; use link instead
    2013-09-10 [BS]
            address can take @role
            glossterm can take @condition
            check copyright is present and in right place
            added more informational messages
    2013-09-10 [BS]
            duplicate DOIs
            fixed column count in tables
            warnings for anonymous items, op cits, ibid
            started cleaning up the file and cross referencing in the data spec
            allow @condition on bibliomset
            contributorStatement
            DOI format check
            warn if unmarked DOIs in text
            changed some warnings to info
    2013-09-06 [BS]
            test for surnames ending with apos + s
            footnotes containing italic and date-like content
            allowed conference elements back in
            warn if a biblio item looks like a conference
            country name test
            nested bibliomsets
    2013-09-04 [BS]
            test for ligatured presentational forms
    2013-09-03 [BS]
            restructured file slightly
            warn if front chunk might need to be a toc
            warn if toc items and info/title start with number
    2013-08-31 [BS]
            [Many other changes since 2013-07-01 as well, but the following were as a result of the first data sample]
            test for duplicated stops around bibl lists
            multiple publishername in bibliomixed
            no text between successive authors in bibliomixed
            warns for possible internal refs
            multiple surnames
            all chunk content in a blockquote is wrong
            warning if footnote content looks like it might be a periodical ref
            added bibliosource to list of unrequired elements
            multiple images required @outputformat
            start and end pagenum are the same
    2013-07-01 [BS]
            allowed cases where personname does not need @role or name components
            enforced info on more blocks which take titles 
            check if @label is empty
    2013-06-28 [BS]
            added more bibl tests
    2013-06-27 [BS]
            ensure DOIs are present on blocks that need them
            ensure book has an xml isbn
            ensure there aren't multiple sbns for the same format
            names with othername and no firstname are wrong
            links and uri checks
            ensured no ignored rules
    2013-06-26 [BS]
            warn if bibliomixed does not contain pubdate
            checks if bibl contains pubdate[@role=accessed], which is wrong
            check if only a single bibliomset in a bibl
            check that bibliomixed and bibliomset contain titles
            check that links containing url text are in uri element
            check if citetitle is used, not sure we need it at all
            Modified othername reporting
            Excluded @morerows condition when testing column numbers
    2013-06-21 [BS]
            copied in DocBook Schematron (http://www.docbook.org/xml/5.0/sch/), made to conform with this version of Schematron, and lightly modified
            added more rules on book ISBNs
            added root @xml:lang check
            started tests for pdfOnly wrappers
            added DOI rules 
            added more pub date checks
            check that titles etc have had their case regularised
            added more elements whose title must be in a info
            modified MIME type test on imagedata
            extended biblioentry tests to cover bibliomixed
            added tests for front matter, prelims, structure, contents etc         
            added initial pagenum tests
            check if it is a Creative Commons title
    2011-03-02 [NG]
	  Updated to fix an error in the indexterm checking.
    2011-02-10 [NG]
	  Added some additional indexterm checking to ensure that footnotes cannot contain start of range marker.
    2011-02-08 [NG] 
	  Schematron relaxed to allow elements within a biblioentry that would normally require an id not to have one.
    2011-02-05 [NG]
	  Added some additional bibliography testing. 
            Ensure that the biblioentry must be of type 'article' if the entry contains a biblioset with role of series.
    2011-01-16 [NG]
            Modified the schematron error checker for structural IDs to allow *only* 3 digit numbers as the numeric part.
            Updated to do some checks on itemized lists with only one element.
    2010-10-26 [NG]
            Corrected an error in the way that column numbers were checked/calculated.
            This was causing warnings to occur when there were no problems with tables.
    2010-09-21 [NG]
            Found small error in bibliographic reference checks that meant that some 'further reading' sections were incorrectly checked for references in the text.
    2010-08-22 [NG]
            Updated biblioentry checks to use xslt 2 syntax 
            Added further firstname checks to stop single letter with no period.
            Added check for indexterms in titles.
            Added check for elements which should *not* have xml:id attributes but do.
    2010-07-20 [NG]
            Added ID format checks.
    2010-07-15 [NG]
            Modifications to edition and volume number checking
            Removal of some (redundant) image checks
    2010-05-31 [NG]
            Moved id checkers to a standalone module.
    2010-02-02 [NG]
            added more table checking.
    2010-02-01 [NG]
            added checking for tables
            corrected a problem introduced when I modularised the code using entities.
    2010-01-22 [NG]
            -a
                added a couple more bibliographic checks.
                started on biblioentry checking
                added new patterns from SB.
                updated with correction to biblioreference checking (from SB)
            -b
                corrected an error noticed by Lakshmanan (checking for titles on monographs was wrong)
                added more bibliography checks
                added an additional link check

-->

<!DOCTYPE schema [


<!ENTITY chunk_blocks "db:chapter|db:acknowledgements|db:book/db:glossary|db:book/db:part/db:glossary|db:preface|db:index|db:book/db:bibliography|db:part/db:bibliography|db:appendix|db:part[db:partintro]|db:toc|db:dedication" >
<!ENTITY chunk_blocks_print "db:chapter[not(ancestor::db:book[@outputformat='e-Only'])][not(@outputformat='web') and not(@outputformat='e-Only') and not(@role='ancillary')] | 
db:acknowledgements[not(ancestor::db:book[@outputformat='e-Only'])][not(@outputformat='web') and not(@outputformat='e-Only') and not(@role='ancillary')] | 
db:book/db:glossary[not(ancestor::db:book[@outputformat='e-Only'])][not(@outputformat='web') and not(@outputformat='e-Only') and not(@role='ancillary')] | 
db:book/db:part/db:glossary[not(ancestor::db:book[@outputformat='e-Only'])][not(@outputformat='web') and not(@outputformat='e-Only') and not(@role='ancillary')] |
db:preface[not(ancestor::db:book[@outputformat='e-Only'])][not(@outputformat='web') and not(@outputformat='e-Only') and not(@role='ancillary')] | 
db:index[not(ancestor::db:book[@outputformat='e-Only'])][not(@outputformat='web') and not(@outputformat='e-Only') and not(@role='ancillary')] | 
db:book/db:bibliography[not(ancestor::db:book[@outputformat='e-Only'])][not(@outputformat='web') and not(@outputformat='e-Only') and not(@role='ancillary')] | 
db:part/db:bibliography[not(ancestor::db:book[@outputformat='e-Only'])][not(@outputformat='web') and not(@outputformat='e-Only') and not(@role='ancillary')] | db:appendix[not(ancestor::db:book[@outputformat='e-Only'])][not(@outputformat='web') and not(@outputformat='e-Only') and not(@role='ancillary')] | 
db:part[db:partintro][not(ancestor::db:book[@outputformat='e-Only'])][not(@outputformat='web') and not(@outputformat='e-Only') and not(@role='ancillary')] | 
db:toc[not(ancestor::db:book[@outputformat='e-Only'])][not(@outputformat='web') and not(@outputformat='e-Only') and not(@role='ancillary')] | 
db:dedication[not(ancestor::db:book[@outputformat='e-Only'])][not(@outputformat='web') and not(@outputformat='e-Only') and not(@role='ancillary')]" >

<!ENTITY pathsWithoutInfoMetaItems-core "not(parent::db:info/parent::db:book) and not(parent::db:info/parent::db:chapter) and not(parent::db:info/parent::db:part) and not(parent::db:info/parent::db:article)">
<!ENTITY pathsWithoutInfoMetaItems-additional " and not(parent::db:info/parent::db:toc) and not(parent::db:info/parent::db:appendix) and not(parent::db:info/parent::db:preface) and not(parent::db:info/parent::db:glossary) and not(parent::db:info/parent::db:index) and not(parent::db:info/parent::db:acknowledgements) and not(parent::db:info/parent::db:dedication) and not(parent::db:info/parent::db:bibliography) and not(parent::db:info/parent::db:section[@role='subArticle'])">
<!ENTITY pathsWithoutInfoMetaItems-all "&pathsWithoutInfoMetaItems-core;&pathsWithoutInfoMetaItems-additional;">

<!ENTITY match_linkend "key('xmlid', current()/@linkend)">
<!ENTITY ancestor_with_id "ancestor::*[@xml:id][1]">
<!ENTITY ancestor_with_id_named "local-name(&ancestor_with_id;)">
<!ENTITY ancestor_id "&ancestor_with_id;/@xml:id">
<!ENTITY ancestor_string '&quot;<value-of select="&ancestor_with_id_named;"/>&quot; element with id &quot;<value-of select="&ancestor_id;"/>&quot;'> 
<!ENTITY check_id "check element with id &quot;<value-of select='@xml:id'/>&quot;">
<!ENTITY check_ancestor "check within &ancestor_string;">
<!ENTITY named_element_with_id '&quot;<name/>&quot; element with id &quot;<value-of select="@xml:id"/>&quot;'> 
<!ENTITY chunk_pdf '[in chunk <value-of select="substring-after(ancestor::element()[not(child::element()/db:info/db:mediaobject/db:imageobject/db:imagedata/@fileref)]/db:info/db:mediaobject/db:imageobject/db:imagedata/@fileref, &quot;pdfs/&quot;)"/>]'>

<!ENTITY precedingPageNoVariable '<let name="precedingPageNo" value="preceding::processing-instruction(page)[1]/substring-after(., &quot;=&quot;)"/>'>

<!ENTITY pageNoAndChunkPDF '[compare print: <value-of select="ancestor::element()[db:info/db:mediaobject//db:imagedata[@format=&quot;application/pdf&quot;]][position()= 1]/db:info/db:mediaobject//db:imagedata[@format=&quot;application/pdf&quot;]/@fileref/substring-after(., &quot;pdfs/&quot;)"/>, on p. <value-of select="$precedingPageNo"/>]'>

]>

<schema xmlns="http://purl.oclc.org/dsdl/schematron"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	queryBinding="xslt2" schemaVersion="5">
	
	<ns uri="http://docbook.org/ns/docbook" prefix='db' />
	<ns uri='http://www.w3.org/XML/1998/namespace' prefix='xml'/>
	<ns uri='http://www.w3.org/1999/xlink' prefix='xlink'/>
    <ns uri="http://www.w3.org/2001/XInclude" prefix="xi"/>
    <ns uri="http://www.w3.org/1998/Math/MathML" prefix="mml" />
    <ns uri="http://saxon.sf.net/" prefix="saxon" />
	
	<let name="docbook-blocks" value="('abstract', 'acknowledgements', 'address', 'appendix', 'article', 'bibliodiv', 'biblioentry', 'bibliography', 'bibliolist', 'bibliomixed', 'bibliomset', 'biblioset', 'blockquote', 'book', 'bridgehead', 'callout', 'calloutlist', 'informaltable', 'table', 'caption', 'caution', 'chapter', 'colophon', 'cover', 'dedication', 'epigraph', 'equation', 'example', 'figure', 'formalpara', 'glossary', 'glossdef', 'glossdiv', 'glossentry', 'glosslist', 'glosssee', 'glossseealso', 'imageobjectco', 'index', 'indexdiv', 'indexterm', 'informalequation', 'informalexample', 'informalfigure', 'itemizedlist', 'legalnotice', 'listitem', 'mediaobject', 'member', 'orderedlist', 'para', 'part', 'partintro', 'personblurb', 'preface', 'primaryie', 'printhistory', 'qandadiv', 'qandaentry', 'qandaset', 'revision', 'secondaryie', 'section', 'seealsoie', 'seeie', 'set', 'setindex', 'sidebar', 'simpara', 'simplesect', 'simplelist', 'subtitle', 'term', 'tertiaryie', 'title', 'toc', 'variablelist' )"/>

	<let name="publishers-blocks" value="('speaker', 'line', 'linegroup', 'poetry', 'dialogue', 'drama')"/>
	
	<let name="other-id-elements"  value="('anchor', 'info', 'entry', 'footnote', 'imageobject', 'inlineequation', 'inlinemediaobject', 'itermset', 'keyword', 'keywordset', 'speaker', 'mathphrase')"/>
	
	<let name="all-blocks" value="($docbook-blocks, $publishers-blocks)"/>
	<let name="all-id-elements" value="($all-blocks, $other-id-elements)"/>

    <let name="elements-with-math-condition" value="('equation', 'informalequation', 'inlineequation')"/>
	
    <let name="elements-with-outputformat" value="('imagedata', 'title', 'book', 'phrase', 'member', 'para', 'mediaobject', 'appendix', 'part', 'chapter', 'section', 'article', 'pubdate')"/>

	<!-- used for duplicated ids later on -->
	<xsl:key name="xmlid" match="*[@xml:id]" use="@xml:id"/> 

	<xsl:key name="doi" match="db:biblioid[@class='doi']" use="text()"/> 

          <xsl:key name="biblio-id" match="db:bibliomixed" use="@xml:id"/>  

          <xsl:key name="linkend" match="*[@linkend]" use="@linkend"/>  

	<xsl:key name="indextype" match="db:index[@type]" use="@type"/> 

	<xsl:key name="indexsee-primary" match="db:indexterm[db:see][not(db:secondary or db:tertiary)]/db:primary" use="text()"/> 
	<xsl:key name="indexsee-secondary" match="db:indexterm[db:see][not(db:primary or db:tertiary)]/db:secondary" use="text()"/> 
	<xsl:key name="indexsee-tertiary" match="db:indexterm[db:see][not(db:secondary or db:primary)]/db:tertiary" use="text()"/> 

	<xsl:key name="primary" match="db:primary" use="text()"/> 

        <xsl:key name="isbns" match="db:biblioid[@class='isbn']" use="translate(., ' -', '')"/> 
        
          <xsl:key name="chunk-ids" match="&chunk_blocks;" use="@xml:id"/>

          <xsl:key name="chunk-pis" match="processing-instruction(insert)" use="."/>
        
        <xsl:key name="objectPointer-ids" match="db:anchor[@role='objectPointer']" use="@xml:id"/>
        
        <xsl:key name="objectTarget-ids" match="element()[@xlink:role='objectPointer']" use="@xlink:href"/>

<pattern id="role-attributes">
<title>A @role attribute is only allowed on the defined list of elements, where they must take the values defined in the schema. If a @role is included on any other element it is an error</title>
<let name="elements-with-defined-role" value="('abstract', 'address', 'anchor', 'appendix', 'article', 'attribution', 'bibliography', 'biblioid', 'bibliolist', 'bibliomisc', 'bibliomixed', 'biblioset', 'bridgehead', 'book', 'chapter', 'cover', 'date', 'dialogue', 'edition', 'emphasis', 'figure', 'firstname', 'footnote', 'foreignphrase', 'imageobject', 'inlinemediaobject', 'keywordset', 'legalnotice', 'line', 'lineage', 'itemizedlist', 'link', 'mediaobject', 'note', 'othercredit', 'othername', 'para', 'part', 'personname', 'phrase', 'preface', 'pubdate', 'releaseinfo', 'section', 'sidebar', 'table', 'title', 'volumenum')"/>
<rule context="*[@role]" id="global">
<report test="not(local-name() = $elements-with-defined-role )" id="test-role-attribute">The <name/> element has a @role attribute (value = <value-of select="@role"/>), but it is not an element that is allowed @role. &check_id;</report>
</rule>
</pattern>

<pattern id="other-attributes">
<title>DocBook attributes</title>
<let name="non-required-attributes" value="('annotations', 'arch', 'audience', 'conformance', 'os', 'remap', 'revision', 'revisionflag', 'security', 'userlevel', 'vendor', 'wordsize')"/>
<rule context="element()/@*" id="other-attributes-rule">
<report test="local-name() = $non-required-attributes" id="illegal-attributes">The <name path="parent::element()"/> element has a @<value-of select="local-name()"/> attribute (value = <value-of select="."/>), which is not permitted in this instance of DocBook, &check_ancestor;</report>
</rule>
</pattern>

<pattern id="linkend-attributes">
<title>A @linkend is only allowed on a defined list of elements. If @linkend is on any other element it is an error</title>
<let name="elements-with-defined-linkend" value="('link', 'section')"/>
<rule context="*[@linkend]" id="linkend-content">
<report test="not(local-name() = $elements-with-defined-linkend )" id="test-linkend-attribute">The <name/> element has a @linkend attribute, but iit is not an element that is allowed @linkend. &check_id;</report>
</rule>
</pattern>


<pattern id="elements-not-required">
<title>Some elements are unlikely ever to be needed in this DocBook instance, so this warns if they occur</title>
<let name="unrequired-elements" value="('acronym', 'area', 'areaset', 'areaspec', 'artpagenums', 'bibliocoverage', 'biblioentry', 'biblioref', 'bibliorelation', 'bibliosource', 'citebiblioid', 'citetitle', 'collab', 'contractnum', 'contractsponsor', 'givenname', 'literal', 'optional', 'orgdiv', 'productname', 'productnumber', 'quote', 'simpara', 'simplesect', 'stepalternatives', 'substeps', 'task', 'taskprerequisites', 'taskrelated', 'tasksummary', 'trademark', 'wordasword', 'xref')"/>
<rule context="*" id="unrequired-elements-context">
<report test="local-name() = $unrequired-elements" id="non-required-elements">The <name/> element is not permitted to be used in this instance of DocBook. If you think it is required in this context, please contact the publisher. &check_ancestor;</report>
</rule>
</pattern>

<pattern id="other-namespace">
<title>Locates anything in another namespace</title>
<rule context="*" id="namespace-context">
<let name="namespace" value="namespace-uri()"/>        
        <assert test="$namespace = ('http://docbook.org/ns/docbook', 'http://www.w3.org/1998/Math/MathML', 'http://www.w3.org/1999/xlink')" id="non-docbook-ns">Element <name/> present with @xmlns = <value-of select="$namespace"/>, &check_ancestor;</assert>
</rule>
</pattern>  

<pattern id="comments">
<title>We need to know if anything has been commented out</title>
<rule context="*" id="comment-context">
&precedingPageNoVariable;
<report test="comment()" id="comment-present" role="warning">A comment is present with content "<value-of select="comment()"/>", &check_ancestor; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

  	<!-- ID CHECKS
  		We need two patterns here because the second rule matches the
  		same elements as the first.
  	-->
	<pattern id='missing_id'>
        <title>We need IDs on content elements, not least so we can report locations within this Schematron. Here we check for an @xml:id attribute on all elements that require it. Additional rules added to ensure that the element is not within a bibliographic entry, so that (for instance) "title" does not need an ID in that context</title>
		<rule context='*[local-name() = $all-id-elements][not(ancestor::db:biblioentry) and not(ancestor::db:bibliomixed)]' id="missing-id-context">
			<assert test='@xml:id' id='missing_id_rule'>All "<name/>" elements must have an "xml:id" attribute; please check the "<name/>" element contained in the &ancestor_string;.</assert>
		</rule>
	</pattern>
    
	<pattern id="duplicated_id"> 
		<!-- check for duplicated ids; could delete this since the schema tests this anyway -->
		<rule context="*[@xml:id]" id="duplicate-id-context"> 
			<assert test="count(key('xmlid', @xml:id)) = 1" id="dupe-id">Duplicated id in element "<name/>" - "<value-of select='@xml:id'/>".</assert>
		</rule> 
	</pattern> 
	
	<pattern id='info_checker'>
        <title>DocBook permits many elements to have a child "title" OR for the "title" to be within an "info". This enforces consistency so that the "title" MUST always be in an "info"</title>
		<rule context='db:book|db:part|db:chapter|db:section|db:table|db:figure|db:mediaobject|db:preface|db:acknowledgements|db:appendix|db:bibliography|db:bibliodiv|db:glossary|db:glossdiv|db:sidebar|db:simplesect|db:abstract|db:bibliolist|db:blockquote|db:colophon|db:dedication|db:dialogue|db:drama|db:equation|db:example|db:formalpara|db:glosslist|db:index|db:itemizedlist|db:orderedlist|db:partintro|db:poetry|db:qandadiv|db:qandaset|db:set|db:variablelist|db:toc' id="title-required-context">
			<report test='db:title' id="title-within-info">The &named_element_with_id; must have an "info" element to contain the title</report>
		</rule>
	</pattern>

	<pattern id='info_checker-2'>
        <title>Some elements MUST always have a title. The schema enforces most of them, but we also want these</title>
		<rule context='db:part | db:toc | db:book/db:part/db:dedication' id="title-required-context-2">
			<assert test='db:info/db:title' id="title-required">The &named_element_with_id; must have a title within an info</assert>
		</rule>
	</pattern>
	

<pattern id="check-title">
<title>The chunk title should not normally contain the words "Chapter" etc, unless there is no chunk title</title>
<rule context="db:example | db:figure | db:appendix | db:chapter | db:part | db:section | db:table | db:equation" id="title-words-context">
&precedingPageNoVariable;
<!-- In the following tests we want to see if the title contains text that would normally be generated by the downstream processor -->
<report test="starts-with(translate(db:info/db:title, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'chapter') and not(ancestor::db:book/db:info/db:biblioid[@otherclass='suppressChapterNumeration'] = '1')" id="chapter-in-title" role="warning">Chunk title starts with 'chapter', it should normally not be present, and have the number stored as @label, unless it is un-numbered or has no other title, &check_id; &pageNoAndChunkPDF;</report>
<report test="starts-with(translate(db:info/db:title, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'appendix')" id="appendix-in-title" role="warning">Chunk title starts with 'appendix', it should normally not be present, and have the number stored as @label, unless it is un-numbered or has no other title, &check_id; &pageNoAndChunkPDF;</report>
<report test="starts-with(translate(db:info/db:title, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'part ')" id="part-in-title" role="warning">Chunk title starts with 'part', it should normally not be present, and have the number stored as @label, unless it is un-numbered or has no other title, &check_id; &pageNoAndChunkPDF;</report>
<report test="starts-with(translate(db:info/db:title, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'example')" id="example-in-title" role="warning">Chunk title starts with 'example', it should normally not be present, and have the number stored as @label, unless it is un-numbered or has no other title, &check_id; &pageNoAndChunkPDF;</report>
<report test="starts-with(translate(db:info/db:title, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'figure')" id="figure-in-title" role="warning">Chunk title starts with 'figure', it should normally not be present, and have the number stored as @label, unless it is un-numbered or has no other title, &check_id; &pageNoAndChunkPDF;</report>
<report test="starts-with(translate(db:info/db:title, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'table')" id="table-in-title" role="warning">Chunk title starts with 'table', it should normally not be present, and have the number stored as @label, unless it is un-numbered or has no other title, &check_id; &pageNoAndChunkPDF;</report>
<report test="starts-with(translate(db:info/db:title, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'equation')" id="equation-in-title" role="warning">Chunk title starts with 'equation', it should normally not be present, and have the number stored as @label, unless it is un-numbered or has no other title, &check_id; &pageNoAndChunkPDF;</report>
<report test="starts-with(translate(db:info/db:title, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'section')" id="section-in-title" role="warning">Chunk title starts with 'section', it should normally not be present, and have the number stored as @label, unless it is un-numbered or has no other title, &check_id; &pageNoAndChunkPDF;</report>
</rule>
</pattern>	

<pattern id="book-id">
<rule context="db:book | db:set" id="id-format-context">
<assert test="starts-with(@xml:id, 'b-')" id="book-id-start">The <name/> ID MUST start with the string "b-", &check_id;</assert>
<assert test="string(translate(db:info/db:biblioset[@role='isbns']/db:biblioid[@role='xml'], ' -', '')) = substring-after(@xml:id,'b-')" id="book-id-end"><name/> DOI must use XML ISBN as its root &check_id;</assert></rule>
</pattern>

<pattern id="chunk-id-req">
<title>Chunk IDs must be preceded with the book ID</title>
<!-- Unfortunately, can't use &chunk_blocks; here, so we need to modify it, and include article as well-->
<rule context="db:chapter[ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '3']][not(db:info[db:biblioid[@otherclass='legalDivType'] = ('statute', 'si')])] | db:acknowledgements[ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '3']] | db:book/db:glossary[ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '3']] | db:book/db:part/db:glossary[ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '3']] | db:preface[ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '3']] | db:index[ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '3']] | db:book/db:bibliography[ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '3']] | db:part/db:bibliography[ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '3']] | db:appendix[ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '3']] | db:part[db:partintro][ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '3']] | db:toc[ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '3']] | db:dedication[ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '3']] | db:article[ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '3']] | db:partintro[ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '3']] | db:formalpara[ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '3']]" id="chunk-id-context">
<let name="book-id" value="ancestor::db:book/@xml:id"/>
<assert test="@xml:id[starts-with(., $book-id)]" id="chunk-id">Element ID must be prefixed by the book ID, currently is <value-of select="@xml:id"/> [Book ID = <value-of select="$book-id"/>].</assert>
<assert test="starts-with(substring-after(@xml:id,$book-id), '-')" id="chunk-id2">Element ID must have a hyphen separating book ID prefix from the rest of the ID, &check_id;</assert>
</rule>
</pattern>

<pattern id="additional-chunk-id-req">
<title>Chunk IDs must be predictable in some contexts</title>
<!-- chapter IDs -->
<rule context="db:chapter[ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '4']][not(@role='labelOverRide')][@label]" id="chapter-id-context">
<let name="chunk-id" value="@xml:id"/>
<let name="chunk-id-1" value="substring-after($chunk-id, 'b-')"/>
<let name="chunk-id-2" value="substring-after($chunk-id-1, '-')"/>
<let name="chunk-id-alpha" value="substring($chunk-id-2, 1, 7)"/>
<let name="chunk-id-numeric" value="substring($chunk-id-2, 8)"/>
<assert test="$chunk-id-alpha = local-name()" id="enforce-id-1">Start component of chunk ID must match element name (<value-of select="local-name()"/>) (ID: <value-of select="$chunk-id-2"/>)</assert>
<assert test="$chunk-id-numeric = @label" id="enforce-id-2">End component of chunk ID must match @label value (ID: <value-of select="$chunk-id-2"/>)</assert>
</rule>
<!-- part IDs -->
<rule context="db:part[ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '4']][not(@role='labelOverRide')][@label]" id="part-id-context">
<let name="chunk-id" value="@xml:id"/>
<let name="chunk-id-1" value="substring-after($chunk-id, 'b-')"/>
<let name="chunk-id-2" value="substring-after($chunk-id-1, '-')"/>
<let name="chunk-id-alpha" value="substring($chunk-id-2, 1, 4)"/>
<let name="chunk-id-numeric" value="substring($chunk-id-2, 5)"/>
<assert test="$chunk-id-alpha = local-name()" id="enforce-id-3">Start component of chunk ID must match element name (<value-of select="local-name()"/>) (ID: <value-of select="$chunk-id-2"/>)</assert>
<assert test="$chunk-id-numeric = @label" id="enforce-id-4">End component of chunk ID must match @label value (ID: <value-of select="$chunk-id-2"/>)</assert>
</rule>
<!-- appendix IDs -->
<rule context="db:appendix[ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '4']][not(@role='labelOverRide')][@label]" id="appendix-id-context">
<let name="chunk-id" value="@xml:id"/>
<let name="chunk-id-1" value="substring-after($chunk-id, 'b-')"/>
<let name="chunk-id-2" value="substring-after($chunk-id-1, '-')"/>
<let name="chunk-id-alpha" value="substring($chunk-id-2, 1, 8)"/>
<let name="chunk-id-numeric" value="substring($chunk-id-2, 9)"/>
<assert test="$chunk-id-alpha = local-name()" id="enforce-id-5">Start component of chunk ID must match element name (<value-of select="local-name()"/>) (ID: <value-of select="$chunk-id-2"/>)</assert>
<assert test="$chunk-id-numeric = @label" id="enforce-id-6">End component of chunk ID must match @label value (ID: <value-of select="$chunk-id-2"/>)</assert>
</rule>
<!-- formalpara IDs -->
<rule context="db:formalpara[ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '4']][ancestor::db:book[db:info/db:biblioid[@otherclass='formalparaNumeric']='1']]" id="formalpara-id-context">
<let name="chunk-id" value="@xml:id"/>
<let name="chunk-id-1" value="substring-after($chunk-id, 'b-')"/>
<let name="chunk-id-2" value="substring-after($chunk-id-1, '-')"/>
<let name="chunk-id-alpha" value="substring($chunk-id-2, 1, 2)"/>
<let name="chunk-id-numeric" value="substring($chunk-id-2, 3)"/>
<assert test="$chunk-id-alpha = 'fp'" id="enforce-id-7">Start component of formalpara ID must be 'fp' (<value-of select="local-name()"/>) (ID: <value-of select="$chunk-id-2"/>)</assert>
<assert test="$chunk-id-numeric = db:info/db:title" id="enforce-id-8">End component of formalpara ID must match info/title value (title=<value-of select="db:info/db:title"/>; ID=<value-of select="$chunk-id-2"/>)</assert>
<assert test="translate(db:info/db:title, '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.', '') = ''" id="formalpara-title">A formalpara title must only contain letters, numbers and full stops, &check_id;</assert>
</rule>
<rule context="db:formalpara[ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '4']][not(ancestor::db:book[db:info/db:biblioid[@otherclass='formalparaNumeric'] = '1'])]/db:info/db:title" id="formalpara-id-context2">
<report test="string-length(translate(., '1234567890.', '')) = 0" id="formalpara-title2" role="warning">If a book contains formalparas with ALL titles containing only numbers and full stops, it should have book/info/biblioid[@otherclass='formalparaNumeric']='1' &check_id;</report>
</rule>
</pattern>
        
        <pattern id="all-ids">
                <title>All IDs</title>
                <rule context="element()[@xml:id][not(db:info[db:biblioid[@otherclass='legalDivType']])][ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '5']]" id="all-id-context">
                        <let name="rootID" value="/db:book/@xml:id"/>
                        <assert test="starts-with(@xml:id, $rootID)" id="all-id-test">An @xml:id must start with the book id (<value-of select="$rootID"/>). Currently = <value-of select="@xml:id"/></assert>
                </rule>
        </pattern>

<pattern id='book_metadata'>
<title>A large collection of tests to check that the book-level metadata is correct</title>
<!-- 1. within book/info -->
		<rule context='db:book/db:info' id="book-info-context">
			<assert test='db:title' id="title-present">Book information must contain a "title" element.</assert>
			<report test='db:title' id="title-value" role="info"><!--[<value-of select="saxon:line-number(db:title)"/>:<value-of select="saxon:column-number(db:title)"/>] -->Book title = "<value-of select="db:title"/>"</report>
			<assert role='warning' test="db:authorgroup|db:author|db:editor" id="no-contributor-in-book">Book information should usually contain at least one "author", "editor" or "authorgroup" element. &check_id;</assert>
            <assert test="db:edition" id="edition-present">Books must contain an edition element. &check_id;</assert>
            <assert test="db:edition/@role" id="edition-role-present">Books must contain an edition/@role with a number equal to the edition number. &check_id;</assert>
			<report test="db:publisher" id="publisher-no-biblioset">The publisher element in the book information must be within the biblioset[@role=publisher]. &check_id;</report>
			<assert test="db:biblioset[@role='publisher']" id="publisher-biblioset">Book information must contain at least one "publisher" element. &check_id;</assert>
			<assert test='db:pubdate[@role="published"]' id="pubdate-present">Book information must contain a "pubdate" element with @role=published to record its original (print) pub date. &check_id;</assert>
			<assert test='string-length(db:pubdate[@role="published"]) = 4' id="pubdate-four-digits">Year in Book "pubdate" with @role=published [original (print) pub date] must be four digits. &check_id;</assert>
			<assert test="count(descendant::db:bibliomisc[@role='imprint']) = 1" id="imprint-count" role="warning">One and only one bibliomisc[@role=imprint] is usually required in book/info, &check_ancestor;</assert>
            <assert test="db:copyright" id="copyright-present">Book information must contain copyright data, &check_id;</assert>
			<assert test='descendant::db:biblioid[@class="isbn"]' id="isbn-present">Book information must contain at least one "biblioid" element with a "class" attribute set to "isbn".</assert>
			<report test='db:biblioid[@class="isbn"]' id="isbns-in-biblioset">The "biblioid"s in the Book information must be within a "biblioset" element with a "role" attribute set to "isbns". &check_id;</report>
			<assert test="count(descendant::db:bibliod[@class='isbn']) = 1 or (count(descendant::db:bibliod[@class='isbn']) = count(descendant::db:bibliod[@class='isbn'][@role]))" id="isbns-role">If more than one "biblioid" with class "isbn" is present, all of them must have role attributes. &check_id;</assert>
			<assert test='db:biblioset[@role="isbns"]' id="biblioset-isbns">Book information must contain a "biblioset" element with a "role" attribute set to "isbns". &check_id;</assert>
			<assert test="db:biblioset[@role='isbns']/db:biblioid[@role='xml']" id="xml-isbn">A book MUST have a XML ISBN, ie the ISBN of the current file format &check_ancestor;</assert>
			<assert test='db:biblioid[@otherclass="schemaVersion"]' id="schema-version-present">Book information must contain a "biblioid" element with a "otherclass" attribute set to "schemaVersion". &check_id;</assert>
			<assert test='db:biblioid[@otherclass="schematronVersion"]' id="schematron-version-present">Book information must contain a "biblioid" element with a "otherclass" attribute set to "schematronVersion". &check_id;</assert>
            <report test="db:biblioid[@otherclass='schematronVersion']" role="info" id="schematron-version-info">schematronVersion = <value-of select="db:biblioid[@otherclass='schematronVersion']"/></report>
			<assert test='db:abstract[@role="blurb"]' id="blurb-present">Book information must contain an "abstract" element with a @role=blurb. &check_id;</assert>
<!-- Info if there is a previous title -->
            <report test="db:bibliomisc[@role='previousTitle']" role="info" id="previous-title">Book has a previous title (<value-of select="db:bibliomisc[@role='previousTitle']"/>), &check_id;</report>
            <report test="db:address" id="publisher-address">address is not permitted as a direct child of book/info. If it is a publisher address, it needs to be within biblioset[@role=publisher]; otherwise contact Bloomsbury</report>
		</rule>
<rule context="db:book[db:info/db:biblioid[@otherclass='allBiblioItemsUnlinked']]" id="bibl-count-context-1">
<report test="db:info/db:biblioid[@otherclass='allBiblioItemsUnlinked'] = '1'" id="info-allBiblioItemsUnlinked" role="info">allBiblioItemsUnlinked = 1</report>
</rule>
<rule context="db:biblioset[@role='isbns'][not(ancestor::db:book[@outputformat='e-Only'])]" id="biblioset-context">
<assert test="count(db:biblioid[not(@role='xml')]) gt 0" id="insufficient-isbns">There must be at least one ISBN other than the XML ISBN for a print book. You may need to check p. iv of the prelims in the pdf, &check_id;</assert>
</rule>
        <rule context="db:biblioid[@class='isbn']" id="isbn-context">
<let name="d1" value="number(substring(string(translate(., ' -', '')),1,1))"/>
<let name="d2" value="number(substring(string(translate(., ' -', '')),2,1)) * 3"/>
<let name="d3" value="number(substring(string(translate(., ' -', '')),3,1))"/>
<let name="d4" value="number(substring(string(translate(., ' -', '')),4,1)) * 3"/>
<let name="d5" value="number(substring(string(translate(., ' -', '')),5,1))"/>
<let name="d6" value="number(substring(string(translate(., ' -', '')),6,1)) * 3"/>
<let name="d7" value="number(substring(string(translate(., ' -', '')),7,1))"/>
<let name="d8" value="number(substring(string(translate(., ' -', '')),8,1)) * 3"/>
<let name="d9" value="number(substring(string(translate(., ' -', '')),9,1))"/>
<let name="d10" value="number(substring(string(translate(., ' -', '')),10,1)) * 3"/>
<let name="d11" value="number(substring(string(translate(., ' -', '')),11,1))"/>
<let name="d12" value="number(substring(string(translate(., ' -', '')),12,1)) * 3"/>
<let name="d13" value="number(substring(string(translate(., ' -', '')),13,1))"/>
<let name="sum" value="$d1 + $d2 + $d3 + $d4 + $d5 + $d6 + $d7 + $d8 + $d9 + $d10 + $d11 + $d12 + $d13"/>
<assert test="matches(string($sum), '0$')" id="isbn-check">ISBN is invalid - checksum incorrect [<value-of select="."/>], &check_ancestor;</assert>
                <assert test="count(key('isbns', translate(., ' -',''))) = 1" id="dupe-isbns">Duplicate ISBNs are not permitted; are all the correct ISBNs present? &check_ancestor;</assert>
                <assert test="@role" id="isbn-role">A <name/> with @class=isbn MUST have a @role, &check_ancestor;</assert>
</rule>
        <rule context="db:bibliomisc[@role='previousTitle']" id="title-in-previous-title">
            <report test="db:title" id="title-previous">A previousTitle must not contain a title element. If it is a previous series title, bibliomisc must be in series block, &check_ancestor;</report>
        </rule>
        <rule context="db:book/db:info/db:author[db:personname] | db:book/db:info/db:editor[db:personname] | db:book/db:info/db:authorgroup/db:author[db:personname] | db:book/db:info/db:authorgroup/db:editor[db:personname]" id="book-person-context">
            <assert test="db:personblurb" id="personblurb-present" role="warning">Person blurb not present in <name/> element in book/info, &check_ancestor;</assert>
            <report test="count(db:personblurb/db:para) gt 1" role="warning" id="personblurb-para">There is more than one para in personblurb. Is that correct? &check_ancestor;</report>
            <report test="count(db:personblurb) gt 1" role="error" id="multiple-personblurb">There is more than one personblurb in this <name/>, which is not correct. &check_ancestor;</report>
            <assert test="@xlink:href" id="author-id-present">Book <name/> must contain a xlink:href with person ID, &check_ancestor;</assert>
            <assert test="@xlink:role='biblioAuID'" id="au-id-marker">Book <name/> must contain a xlink:role=biblioAuID, &check_ancestor;</assert>
        </rule>
        <rule context="db:personblurb" id="personblurb-context">
            <report test="string(.) = string(preceding::db:personblurb[1])" role="warning" id="personblurb-duplicate">Person blurb is identical to the preceding one, OK? It should contain details about only one person, &check_ancestor;</report>
        </rule>
        <rule context="db:book/db:info/db:othercredit[db:personname] | db:book/db:info/db:authorgroup/db:othercredit[db:personname]" id="person-other-context">
            <assert test="@xlink:href" id="author-id-present-2" role="warning">Book <name/> should usually contain a xlink:href with person ID, &check_ancestor;</assert>
            <assert test="@xlink:role='biblioAuID'" id="au-id-marker-2" role="warning">Book <name/> should usually contain a xlink:role=biblioAuID, &check_ancestor;</assert>
        </rule>
<!-- 3. publisher data -->
        <rule context="db:biblioset[@role='publisher']" id="publisher-context">
            <assert test="db:publisher" id="biblioset-publisher">The publisher block must contain the name of the publisher. &check_id;</assert>
            <assert test="db:bibliomisc[@role='imprint']" id="imprint-present" role="warning">The publisher block should usually contain imprint details. &check_id;</assert>
                <assert test="if (preceding-sibling::db:biblioset[@role='publisher']) then 1 else (descendant::db:address)" id="pub-address-missing">The biblioset[@role=publisher] does not contain an address. It needs to include the publisher address details, &check_id;</assert>
                <assert test="if (preceding-sibling::db:biblioset[@role='publisher']) then 1 else (descendant::db:address[1]/db:city)" id="pub-city-missing">The first address in a biblioset[@role=publisher] must contain a city, &check_id;</assert>
        </rule>
        <rule context="db:biblioset[@role='publisher']//db:address" id="pub-address-context">
            <assert test="parent::db:publisher" id="pub-address-location">An <name/> in biblioset[@role=publisher] must be an immediate child of publisher, &check_id;</assert>
            <assert test="db:street | db:city | db:state | db:country | db:pob | db:postcode | db:otheraddr | db:link" id="address-components">Addresses in the publisher block must have their components marked up, &check_id;</assert>
            <report test="text()[matches(., '[a-z]+')]" id="unmarked-address">Address in publisher block contains un-marked up text, &check_id;</report>
        </rule>
        <rule context="db:biblioset[@role='publisher']/db:address[1]/db:city" id="pub-city-context">
                <report test="matches(., '\p{N}+')" id="pub-city-content">The <name/> in biblioset[@role=publisher]/address[1] must only contain letters (no numbers), &check_ancestor;</report>
        </rule>
        <rule context="db:biblioset[@role='companionWebsite']" id="companion-context">
                <assert test="parent::db:biblioset[@role='publisher']" id="companion-location">A companionWebsite block MUST be within the biblioset[@role=publisher], &check_id;</assert>
                <assert test="ancestor::db:info/db:biblioid[@otherclass='hasOnlineResources'] = 'Y'" id="companion-flag">If there is a companionWebsite block, there must be a biblioid[@otherclass=hasOnlineResources] = 'Y', &check_id;</assert>
        </rule>
        <!-- 4. imprint data -->
		<rule context='db:bibliomisc[@role = "imprint"]' id="imprint-context">
			<assert test='parent::db:biblioset[@role="publisher"]' id="imprint-in-biblioset">The parent element of the imprint must be a biblioset. &check_ancestor;</assert>
			<assert test='preceding-sibling::db:publisher or following-sibling::db:publisher' id="imprint-position">If an imprint is defined it must be a sibling of a publisher element. &check_ancestor;</assert>
            <report test="contains(., 'Continuum International Publishing Group')" id="imprint-continuum" role="warning">Imprint contains "Continuum International Publishing Group"; probably should just be "Continuum", &check_ancestor;</report>
            <report test="contains(., 'Bloomsbury Publishing Plc')" id="imprint-bloomsbury-publishing" role="warning">Imprint contains "Bloomsbury Publishing Plc", which should probably be the publishername &check_ancestor;</report>
            <assert test="matches(., '[A-Z]+')" id="lower-case-imprint">The imprint only contains lower case letters, which is incorrect. Does it need an initial capital? &check_ancestor;</assert>
             <report test="matches(., '^([\p{Lu} ]+)$')" id="upper-case-imprint">The imprint only contains upper case letters, which is incorrect. It should have initial capitals &check_ancestor;</report>
	     <report test="db:emphasis" id="imprint-emphasis" role="warning">Imprint contains emphasis element, which is almost certainly incorrect, &check_ancestor;</report>
		        <report test="contains(., 'Published')" id="imprint-published" role="error">Imprint contains the word "Published"; additional text other than the imprint name must be in a phrase, &check_ancestor;</report>
		</rule>
        <rule context="db:book/db:info//db:publishername" id="publishername-context">
            <report test="contains(., 'imprint')" id="phrase-in-publishername">The book/info publisher name must just contain the name of the publisher. Preamble text must be in a phrase, &check_ancestor;</report>
            <report test="matches(., '^([\p{Lu} ()]+)$')" id="upper-case-publishername">The <name/> only contains upper case letters, which is incorrect. It should have initial capitals &check_ancestor;</report>
        </rule>
<!-- 5. Publisher -->
        <rule context="db:book/db:info//db:link[db:uri and not(ancestor::db:personblurb)]" id="pub-url-context">
            <assert test="ancestor::db:publisher/db:address" id="publisher-url" role="warning">A url in the book/info may be the publisher URL; if so it must be included within the biblioset[@role=publisher] block and should probably be in an address as well, &check_ancestor;</assert>
        </rule>
<!-- 6. Copyright -->
        <rule context="db:copyright" id="copyright-context">
            <assert test="parent::db:info" id="info-copyright">"copyright" element must be a direct child of the book/info, &check_ancestor;</assert>
        </rule>
        <rule context="db:holder" id="holder-context">
            <report test="starts-with(., '(c)')or starts-with(., '©')" id="copyright-holder">Element <name/> in copyright line must not start with the (c) symbol, &check_ancestor;</report>
                <report test="contains(., 'Act 1988')" id="holder-act">The <name/> contains a reference to the Copyright Act 1988; this text MUST not be in the copyright statement. Move it to info/legalnotice, &check_ancestor;</report>
                <report test="matches(., '\d\d\d\d')" role="warning" id="holder-year">Element <name/> in copyright line contains a four digit number; years MUST NOT be in the holder element, &check_ancestor;</report>
        </rule>
        <rule context="db:copyright/db:year" id="copy-year-context">
                <report test="starts-with(., '(c)')or starts-with(., '©')" id="copyright-year">Element <name/> in copyright line must not start with the (c) symbol, &check_ancestor;</report>
        </rule>
        <!-- 7. other metadata and test tool version -->
        <rule context='db:biblioid[@otherclass="fiction"]' id="fiction-context">
            <assert test="string() = ('0', '1')" id="fiction-test">Fiction biblioid value (<value-of select="@otherclass"/>) is not one of the permitted values. &check_ancestor;</assert>
            <report test="string() = '1'" id="fiction-info" role="info">Book is a work of Fiction (biblioid[@otherclass=fiction])</report>
        </rule>
        <rule context='db:biblioid[@otherclass="suppressChapterNumeration"]' id="ch-num-context">
            <assert test="string() = ('0', '1')" id="chapter-numeration-test">suppressChapterNumeration value is not one of the permitted values. &check_ancestor;</assert>
            <report test="string() = '1'" id="chapter-numeration-info" role="info">Book has its chapter numeration switched off (biblioid[@otherclass=suppressChapterNumeration])</report>
        </rule>
        <rule context='db:biblioid[@otherclass="schemaVersion"]' id="sch-v-context">
            <assert test="string() = '1'" id="schema-version-test">Schema version number is not one of the permitted values. &check_ancestor;</assert>
        </rule>
    	<rule context='db:biblioid[@otherclass="schematronVersion"]' id="schtr-v-context">
            <assert test="string() = ('1', '2', '3', '4', '5')"  id="schematron-version-test">Schematron version number is not one of the permitted values. &check_ancestor;</assert>
        </rule>
    	<rule context='db:biblioid[@otherclass="hasOnlineResources"]' id="onlineresource-context">
            <assert test="string() = ('Y', 'N')" id="hasOnlineResources-test">@hasOnlineResources content is not one of the permitted values. &check_ancestor;</assert>
            <report test="string() = 'Y'" id="hasOnlineResources-info" role="info">@hasOnlineResources = Y</report>
        </rule>
    	<rule context='db:biblioid[@otherclass="biblioType"]' id="biblioType-context">
            <assert test="string() = ('initials-without-stops', 'initials-with-stops')" id="biblioType-test">@otherclass=biblioType content is not one of the permitted values. &check_ancestor;</assert>
            <report test="string() = 'initials-without-stops'" id="biblioType-info" role="info">@biblioType = initials-without-stops</report>
        </rule>
    	<rule context='db:biblioid[@otherclass="taxonRank"]' id="taxonRank-context">
            <assert test="string() = ('kingdom', 'division', 'phylum', 'class', 'subclass', 'supercohort', 'cohort', 'superorder', 'order', 'suborder', 'hyporder', 'infraorder', 'parvorder', 'superfamily', 'family', 'subfamily', 'tribe', 'genus', 'subgenus', 'species')" id="taxonRank-test">@otherclass=taxonRank content is not one of the permitted values (=<value-of select="."/>). &check_ancestor;</assert>
        </rule>
    	<rule context='db:biblioid[@otherclass="legalContentType"]' id="legalContentType-context">
            <assert test="string() = ('commentary', 'legislation', 'cases', 'newsletter', 'precedents')" id="legalContentType-test">@otherclass=legalContentType content is not one of the permitted values (=<value-of select="."/>). &check_ancestor;</assert>
    	        <assert test="if (. = 'cases') then 1 else (ancestor::db:book/db:info/db:date[@role='lawStatedAt'])" role="warning" id="lawstatedate-missing">Book has a legalContentType value, but no book/info/date[@role='lawStatedAt'], &check_ancestor;</assert>
        </rule>
        <rule context='db:biblioid[@otherclass="DOInotRequired"]' id="DOInotRequired-context">
                <assert test="string() = ('1', '0')" id="DOInotRequired-test">@otherclass=DOInotRequired content is not one of the permitted values (=<value-of select="."/>). &check_ancestor;</assert>
        </rule>
        <rule context='db:biblioid[@otherclass="specialBookType"]' id="specialBookType-context">
                <assert test="string() = ('bflBiblioGuide')" id="specialBookType-test">@otherclass=specialBookType content is not one of the permitted values (=<value-of select="."/>). &check_ancestor;</assert>
        </rule>
        <rule context='db:biblioid[@otherclass="bedArticleType"]' id="bedArticleType-context">
            <assert test="string() = ('Designers', 'Artists', 'Photographers', 'Makers', 'Retailers','Critics, Theorists, Historians', 'Design Studios', 'Design Consultancies', 'Design Museums', 'Design Centers', 'Retail Stores', 'Societies and Professional Associations', 'Trades Unions', 'Manufacturers', 'Colleges, Universities and Programs', 'Periodicals', 'Websites', 'Cinema', 'Television', 'Books', 'Radio', 'Automobile Design', 'Fashion Design', 'Concepts and Issues', 'Exhibitions', 'Prizes and Awards', 'Countries', 'Cities', 'Materials and Processes', 'Methods and Methodologies', 'Designed Things and Brands', 'Schools, Movements and Styles')" id="bedArticleType-test">@otherclass=bedArticleType content is not one of the permitted values (=<value-of select="."/>). &check_ancestor;</assert>
        </rule>
	</pattern>
        
        <pattern id="isbn-tests">
                <title>Specific ISBN tests</title>
                <rule context="db:biblioid[@role='otherVolume']" id="otherVol-context">
                        <assert test="@xlink:type='resource'" id="resource-required">A <name/> with @role=otherVolume must have @xlink:type=resource, &check_ancestor;</assert>
                        <assert test="@xlink:label" id="label-required">A <name/> with @role=otherVolume must have @xlink:label, &check_ancestor;</assert>
                </rule>
        </pattern>

<pattern id="taxa">
<title>Specific tests for taxa, taxon names etc</title>
<rule context="db:title[db:phrase[@role='taxonName']]" id="taxon-title-context">
<assert test="following-sibling::db:biblioid[@otherclass='taxonRank']" id="taxon-title-rank">A chunk with a title containing a taxonName must have a biblioid[@otherclass=taxonRank], &check_id;</assert>
</rule>
        <rule context="db:phrase[@role='taxonName']" id="taxon-name-content">
                <assert test="if (db:emphasis[@role='italic']) then (not(text())) else (not(element()))" id="taxonName-italic-or-text">A taxonName must either be entirely in italic or only contain text(); A name after an italic taxonName must not be within the taxonName [<value-of select="."/>], &check_ancestor;</assert>
                <report test="ends-with(., '.') or ends-with(., ',') or ends-with(., ';')" id="taxon-name-punc">A taxonName must not end with punctuation; it must only contain the taxon name, &check_ancestor;</report>
        </rule>
<rule context="db:biblioid[@otherclass='taxonRank']" id="taxon-biblioid-context">
<assert test="preceding-sibling::db:title[db:phrase[@role='taxonName']]" id="taxon-biblioid-rank">A chunk with a biblioid[@otherclass=taxonRank] must have a title containing a taxonName, &check_ancestor;</assert>
<assert test="parent::db:info/parent::db:part or parent::db:info/parent::db:chapter" id="taxonRank-part-or-chapter">A chunk with biblioid taxonRank must be either a part or a chapter, &check_ancestor;</assert>
</rule>
<rule context="db:part[db:info/db:biblioid[@otherclass='taxonRank']] |  db:chapter[db:info/db:biblioid[@otherclass='taxonRank']]" id="taxon-siblings-context">
<let name="siblings" value="count(preceding-sibling::db:part[not(@role='front')][not(db:info/db:biblioid[@otherclass='taxonRank'])]) + count(following-sibling::db:part[not(@role='back')][not(db:info/db:biblioid[@otherclass='taxonRank'])]) + count(preceding-sibling::db:chapter[not(db:info/db:biblioid[@otherclass='taxonRank'])]) + count(following-sibling::db:chapter[not(db:info/db:biblioid[@otherclass='taxonRank'])])"/>
<report test="if ($siblings gt 0) then (not(preceding-sibling::element()/db:info/db:biblioid[@otherclass='taxonRank']) or not(following-sibling::element()/db:info/db:biblioid[@otherclass='taxonRank'])) else 0" role="warning" id="taxon-siblings">For chunks with taxonRank, its preceding and following siblings [total=<value-of select="$siblings"/>] should usually also have taxonRank, &check_id;</report>
</rule>
</pattern>

<pattern id="taxa2">
<title>More tests for taxa and biological data</title>
<rule context="db:part/db:info[db:title/db:phrase[@role='taxonRank']]" id="taxon-rank-context">
<assert test="string(translate(db:title/db:phrase[@role='taxonRank'], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')) = string(db:biblioid[@otherclass='taxonRank'])" id="taxon-rank-check">If there is a taxonRank in the title (= <value-of select="db:title/db:phrase[@role='taxonRank']"/>), it must match that in the biblioid (= <value-of select="db:biblioid[@otherclass='taxonRank']"/>), &check_id;</assert>
</rule>
</pattern>

<pattern id="taxa3">
<title>More tests for taxa</title>
<rule context="db:part[db:info/db:biblioid[@otherclass='taxonRank']][parent::db:part] |  db:chapter[db:info/db:biblioid[@otherclass='taxonRank']][parent::db:part]" id="taxon-parent-context">
<assert test="parent::db:part[db:info/db:biblioid[@otherclass='taxonRank']]" id="taxon-parent" role="warning">For chunks with taxonRank, its parent should usually have a taxonRank, &check_id;</assert>
</rule>
</pattern>

<pattern id="taxa4">
<title>Tests to ensure that taxa are nested correctly</title>
<rule context="db:chapter/db:info/db:biblioid[@otherclass='taxonRank']" id="taxon-chapter-context">
<assert test="matches(., 'species')" id="taxon-chapter" role="warning">For chunks with taxonRank which are chapters, it is very unusual for the taxonRank not to be 'species', &check_id;</assert>
<assert test="parent::db:info/parent::db:chapter/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'genus'] or parent::db:info/parent::db:chapter/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'subgenus']" role="warning" id="species-parent">The parent node of a species chunk should usually be a genus, but it is '<value-of select="parent::db:info/parent::db:chapter/parent::db:part/db:info/db:biblioid[@otherclass='taxonRank']"/>'. See chunk with ID = <value-of select="parent::db:info/parent::db:chapter/parent::db:part/@xml:id"/></assert>
</rule>
<rule context="db:part/db:info[db:biblioid[@otherclass='taxonRank'] = 'subgenus']" id="subgenus-context">
<assert test="parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'genus']" role="warning" id="subgenus-parent">The parent node of a subgenus chunk should usually be a genus, but it is '<value-of select="parent::db:part/parent::db:part/db:info/db:biblioid[@otherclass='taxonRank']"/>'. See chunk with ID = <value-of select="parent::db:part/parent::db:part/@xml:id"/></assert>
</rule>
<rule context="db:part/db:info[db:biblioid[@otherclass='taxonRank'] = 'genus']" id="genus-context">
<assert test="parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'family'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'subfamily'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'tribe']" role="warning" id="genus-parent">The parent node of a genus chunk should usually be a family, subfamily or tribe, but it is '<value-of select="parent::db:part/parent::db:part/db:info/db:biblioid[@otherclass='taxonRank']"/>'. See chunk with ID = <value-of select="parent::db:part/parent::db:part/@xml:id"/></assert>
</rule>
<rule context="db:part/db:info[db:biblioid[@otherclass='taxonRank'] = 'tribe']" id="tribe-context">
<assert test="parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'family'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'subfamily']" role="warning" id="tribe-parent">The parent node of a tribe chunk should usually be a family or subfamily, but it is '<value-of select="parent::db:part/parent::db:part/db:info/db:biblioid[@otherclass='taxonRank']"/>'. See chunk with ID = <value-of select="parent::db:part/parent::db:part/@xml:id"/></assert>
</rule>
<rule context="db:part/db:info[db:biblioid[@otherclass='taxonRank'] = 'subfamily']" id="subfamily-context">
<assert test="parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'family']" role="warning" id="subfamily-parent">The parent node of a subfamily chunk should usually be a family, but it is '<value-of select="parent::db:part/parent::db:part/db:info/db:biblioid[@otherclass='taxonRank']"/>'. See chunk with ID = <value-of select="parent::db:part/parent::db:part/@xml:id"/></assert>
</rule>
<rule context="db:part/db:info[db:biblioid[@otherclass='taxonRank'] = 'family']" id="family-context">
<assert test="parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'superfamily'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'parvorder'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'infraorder'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'hyporder'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'suborder'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'order']" role="warning" id="family-parent">The parent node of a family chunk should usually be a 'order', 'suborder', 'hyporder', 'infraorder', 'parvorder', or 'superfamily', but it is '<value-of select="parent::db:part/parent::db:part/db:info/db:biblioid[@otherclass='taxonRank']"/>'. See chunk with ID = <value-of select="parent::db:part/parent::db:part/@xml:id"/></assert>
</rule>
<rule context="db:part/db:info[db:biblioid[@otherclass='taxonRank'] = 'superfamily']" id="superfamily-context">
<assert test="parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'parvorder'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'infraorder'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'hyporder'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'suborder'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'order']" role="warning" id="superfamily-parent">The parent node of a superfamily chunk should usually be a 'order', 'suborder', 'hyporder', 'infraorder', or 'parvorder', but it is '<value-of select="parent::db:part/parent::db:part/db:info/db:biblioid[@otherclass='taxonRank']"/>'. See chunk with ID = <value-of select="parent::db:part/parent::db:part/@xml:id"/></assert>
</rule>
<rule context="db:part/db:info[db:biblioid[@otherclass='taxonRank'] = 'parvorder']" id="parvorder-context">
<assert test="parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'infraorder'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'hyporder'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'suborder'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'order']" role="warning" id="parvorder-parent">The parent node of a parvorder chunk should usually be a 'order', 'suborder', 'hyporder', or 'infraorder', but it is '<value-of select="parent::db:part/parent::db:part/db:info/db:biblioid[@otherclass='taxonRank']"/>'. See chunk with ID = <value-of select="parent::db:part/parent::db:part/@xml:id"/></assert>
</rule>
<rule context="db:part/db:info[db:biblioid[@otherclass='taxonRank'] = 'infraorder']" id="infraorder-context">
<assert test="parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'hyporder'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'suborder'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'order']" role="warning" id="infraorder-parent">The parent node of a infraorder chunk should usually be a 'order', 'suborder', or 'hyporder', but it is '<value-of select="parent::db:part/parent::db:part/db:info/db:biblioid[@otherclass='taxonRank']"/>'. See chunk with ID = <value-of select="parent::db:part/parent::db:part/@xml:id"/></assert>
</rule>
<rule context="db:part/db:info[db:biblioid[@otherclass='taxonRank'] = 'hyporder']" id="hyporder-context">
<assert test="parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'suborder'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'order']" role="warning" id="hyporder-parent">The parent node of a hyporder chunk should usually be a 'order', or 'suborder', but it is '<value-of select="parent::db:part/parent::db:part/db:info/db:biblioid[@otherclass='taxonRank']"/>'. See chunk with ID = <value-of select="parent::db:part/parent::db:part/@xml:id"/></assert>
</rule>
<rule context="db:part/db:info[db:biblioid[@otherclass='taxonRank'] = 'suborder']" id="suborder-context">
<assert test="parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'order']" role="warning" id="suborder-parent">The parent node of a suborder chunk should usually be a 'order', but it is '<value-of select="parent::db:part/parent::db:part/db:info/db:biblioid[@otherclass='taxonRank']"/>'. See chunk with ID = <value-of select="parent::db:part/parent::db:part/@xml:id"/></assert>
</rule>
<rule context="db:part/db:info[db:biblioid[@otherclass='taxonRank'] = 'order']" id="order-context">
<assert test="parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'superorder'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'cohort'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'supercohort'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'subclass'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'class']" role="warning" id="order-parent">The parent node of a order chunk should usually be a 'class', 'subclass', 'supercohort', 'cohort', or 'superorder', but it is '<value-of select="parent::db:part/parent::db:part/db:info/db:biblioid[@otherclass='taxonRank']"/>'. See chunk with ID = <value-of select="parent::db:part/parent::db:part/@xml:id"/></assert>
</rule>
<rule context="db:part/db:info[db:biblioid[@otherclass='taxonRank'] = 'superorder']" id="superorder-context">
<assert test="parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'cohort'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'supercohort'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'subclass'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'class']" role="warning" id="superorder-parent">The parent node of a superorder chunk should usually be a 'class', 'subclass', 'supercohort', or 'cohort', but it is '<value-of select="parent::db:part/parent::db:part/db:info/db:biblioid[@otherclass='taxonRank']"/>'. See chunk with ID = <value-of select="parent::db:part/parent::db:part/@xml:id"/></assert>
</rule>
<rule context="db:part/db:info[db:biblioid[@otherclass='taxonRank'] = 'cohort']" id="cohort-context">
<assert test="parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'supercohort'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'subclass'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'class']" role="warning" id="cohort-parent">The parent node of a cohort chunk should usually be a 'class', 'subclass', or 'supercohort', but it is '<value-of select="parent::db:part/parent::db:part/db:info/db:biblioid[@otherclass='taxonRank']"/>'. See chunk with ID = <value-of select="parent::db:part/parent::db:part/@xml:id"/></assert>
</rule>
<rule context="db:part/db:info[db:biblioid[@otherclass='taxonRank'] = 'supercohort']" id="supercohort-context">
<assert test="parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'subclass'] or parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'class']" role="warning" id="supercohort-parent">The parent node of a supercohort chunk should usually be a 'class', or 'subclass', but it is '<value-of select="parent::db:part/parent::db:part/db:info/db:biblioid[@otherclass='taxonRank']"/>'. See chunk with ID = <value-of select="parent::db:part/parent::db:part/@xml:id"/></assert>
</rule>
<rule context="db:part/db:info[db:biblioid[@otherclass='taxonRank'] = 'subclass']" id="subclass-context">
<assert test="parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'class']" role="warning" id="subclass-parent">The parent node of a subclass chunk should usually be a 'class', but it is '<value-of select="parent::db:part/parent::db:part/db:info/db:biblioid[@otherclass='taxonRank']"/>'. See chunk with ID = <value-of select="parent::db:part/parent::db:part/@xml:id"/></assert>
</rule>
<rule context="db:part/db:info[db:biblioid[@otherclass='taxonRank'] = 'class']" id="class-context">
<assert test="parent::db:part/parent::db:part[db:info/db:biblioid[@otherclass='taxonRank'] = 'kingdom']" role="warning" id="class-parent">The parent node of a class chunk should usually be a 'kingdom', but it is '<value-of select="parent::db:part/parent::db:part/db:info/db:biblioid[@otherclass='taxonRank']"/>'. See chunk with ID = <value-of select="parent::db:part/parent::db:part/@xml:id"/></assert>
</rule>
</pattern>

<pattern id="taxa5">
<title>Tests to ensure that taxa siblings are the same</title>
<rule context="db:part[db:info/db:biblioid[@otherclass='taxonRank']][preceding-sibling::db:part[db:info/db:biblioid[@otherclass='taxonRank']]]" id="taxon-siblings2-context">
<let name="myTaxonRank" value="db:info/db:biblioid[@otherclass='taxonRank']"/>
<let name="myPrecedingTaxonRank" value="preceding-sibling::db:part/db:info/db:biblioid[@otherclass='taxonRank']"/>
<assert test="$myTaxonRank = $myPrecedingTaxonRank" id="sibling-taxon" role="warning">The taxonRank of a chunk (<value-of select="$myTaxonRank"/>) is often the same as its preceding-sibling (<value-of select="$myPrecedingTaxonRank"/>), &check_id;</assert>
</rule>
<rule context="db:chapter[db:info/db:biblioid[@otherclass='taxonRank']][preceding-sibling::db:chapter[db:info/db:biblioid[@otherclass='taxonRank']]]" id="taxon-siblings3-context">
<let name="myTaxonRank" value="db:info/db:biblioid[@otherclass='taxonRank']"/>
<let name="myPrecedingTaxonRank" value="preceding-sibling::db:chapter/db:info/db:biblioid[@otherclass='taxonRank']"/>
<assert test="$myTaxonRank = $myPrecedingTaxonRank" id="sibling-taxon2" role="warning">The taxonRank of a chunk (<value-of select="$myTaxonRank"/>) is often the same as its preceding-sibling (<value-of select="$myPrecedingTaxonRank"/>), &check_id;</assert>
</rule></pattern>
        
        <pattern id="case-reports">
                <title>Legal Case Reports (and some Legislation) tests</title>
                <rule context="db:note" id="note-context">
                        <assert test="ancestor::db:book/db:info/db:biblioid[@otherclass='legalContentType'] = ('cases', 'legislation')" id="note-cases">A <name/> can only occur within a Case Report or Legislation volume (db:biblioid[@otherclass='legalContentType'] = ('cases', 'legislation')), &ancestor_id;</assert>
                        <assert test="@role" id="note-role">A <name/> must have @role, &ancestor_id;</assert>
                </rule>
                <rule context="db:book[not(db:info/db:biblioid[@otherclass='legalContentType'] = 'cases')]//db:biblioid" id="not-case-context">
                        <report test="@otherclass = ('courtCode', 'decisionDate', 'caseCitation', 'shortCaseName', 'shortCourtName')" id="case-id-types">A book that is not a Case Report must not contain a biblioid with @otherclass = courtCode, decisionDate, caseCitation, shortCaseName, shortCourtName, &check_id;</report>
                </rule>
                <rule context="db:book[not(db:info/db:biblioid[@otherclass='legalContentType'] = 'cases')]//db:para" id="not-case-context2">
                        <report test="@role = ('caseNumber', 'catchwords', 'court', 'hearingDate', 'judgmentBy', 'judgmentDate', 'legalRepresentation', 'panel')" id="case-role-types">A book that is not a Case Report must not contain a para with @role = 'caseNumber', 'catchwords', 'court', 'hearingDate', 'judgmentBy', 'judgmentDate', 'legalRepresentation', 'panel', &check_id;</report>
                </rule>
                <rule context="db:biblioid[@otherclass='courtCode'] | db:biblioid[@otherclass='decisionDate'] | db:biblioid[@otherclass='caseCitation'] | db:biblioid[@otherclass='shortCaseName'] | db:biblioid[@otherclass='shortCourtName']" id="case-biblioid-context">
                        <assert test="parent::db:info/parent::db:chapter" id="case-biblioid-location">A biblioid with @otherclass = courtCode, decisionDate, caseCitation, shortCaseName, shortCourtName can only occur within a chapter/info, &check_ancestor;</assert>
                </rule>
                <rule context="db:biblioid[@otherclass='decisionDate']" id="decision-date-context">
                        <assert test=". castable as xs:date" id="decision-date">A decisionDate must be an ISO date yyyy-mm-dd, &check_ancestor;</assert>
                </rule>
                <rule context="db:phrase[@role='caseName']" id="case-name-context">
                        <assert test="ancestor::db:book[db:info/db:biblioid[@otherclass='legalContentType'] = ('cases', 'legislation')]" id="case-name-location">A <name/>[@role=caseName] can only occur in a book with biblioid[@otherclass=legalContentType]='cases','legislation', &check_ancestor;</assert>
                        <report test="processing-instruction()" id="case-pi">A <name/>[@role=caseName] must not contain a processing instruction (a PI should be outside the phrase element), &check_ancestor;</report>
                </rule>
                <rule context="db:book[db:info/db:biblioid[@otherclass='legalContentType'] = 'cases']//db:chapter/db:info/db:title" id="case-title-context">
                        <assert test="db:phrase[@role='caseName']" role="error" id="case-title-phrase">A chapter title in a case report must have the case name marked in a phrase, &check_id;</assert>
                </rule>
        </pattern>
        
        <pattern id="case2">
                <title>Additional Case Report and Legislation tests</title>
                <rule context="db:note[ancestor::db:book/db:info/db:biblioid[@otherclass='legalContentType'] = ('legislation')]" id="leg-note-context">
                        <assert test="@role = ('annotations')" id="leg-note">If biblioid[@otherclass='legalContentType'] = ('legislation') then a note/@role can only be 'annotations', &check_id;</assert>
                </rule>
                <rule context="db:note[ancestor::db:book/db:info/db:biblioid[@otherclass='legalContentType'] = ('cases')]" id="leg-case-context">
                        <assert test="@role = ('disposition', 'facts', 'history', 'holding', 'judgment')" id="leg-case">If biblioid[@otherclass='legalContentType'] = ('cases') then a note/@role can only be ('disposition', 'facts', 'history', 'holding', 'judgment'), &check_id;</assert>
                </rule>
        </pattern>
        
        <pattern id="legislation">
                <title>Tests for Annotated Legislation</title>
                <rule context="db:book/db:info[db:biblioid[@otherclass='legalContentType'] = 'legislation']" id="legislation-context">
                        <assert test="db:biblioid[@otherclass='legalJurisdiction']" id="jurisdiction-required">A jurisdiction is required for a legislation volume, &check_ancestor;</assert>
                </rule>
                <rule context="db:book/db:info[db:biblioid[@otherclass='legalJurisdiction']]" id="jurisdiction-context">
                        <assert test="db:biblioid[@otherclass='legalContentType'] = 'legislation'" id="legislation-required">A  volume with a jurisdiction must have a legislation in book/info, &check_ancestor;</assert>
                </rule>
                <rule context="db:biblioid[@otherclass='legalJurisdiction']" id="jurisdiction-context2">
                        <assert test=". = ('ie', 'uk')" id="jurisdiction-values">A biblioid[@otherclass='legalJurisdiction'] can only have one of the values ('ie', 'uk'), &check_ancestor;
                        </assert>
                        <assert test="parent::db:info/parent::db:book" id="jurisdiction-location">A jurisdiction can only occur within a book/info, &check_ancestor;</assert>
                </rule>
                <rule context="db:biblioid[@otherclass='legalDivType']" id="legislation-divisions-context">
                        <assert test=". = ('statute', 'si', 'part', 'chapter', 'section', 'schedule')" id="legislation-divisions">A biblioid[@otherclass='legalDivType'] can only have one of the values ('statute', 'si', 'part', 'chapter', 'section', 'schedule'), &check_ancestor;
                        </assert>
                        <assert test="parent::db:info/parent::db:chapter or parent::db:info/parent::db:section" id="legislation-divisions-location">A biblioid[@otherclass='legalDivType'] can only occur within a chapter/info or section/info, &check_ancestor;</assert>
                </rule>
        </pattern>
        
        <pattern id="legislation2">
                <title>More legislation tests</title>
                <rule context="db:biblioid[@otherclass='legalDivType'][. = ('statute', 'si')]" id="legislation-chapter-context">
                        <assert test="parent::db:info/parent::db:chapter" id="legislation-chapter">A biblioid[@otherclass='legalDivType'] = ('statute', 'si') must be in a chapter, &check_ancestor;</assert>
                </rule>
                <rule context="db:biblioid[@otherclass='legalDivType'][. = ('part', 'chapter', 'section', 'schedule')]" id="legislation-section-context">
                        <assert test="parent::db:info/parent::db:section" id="legislation-section">A biblioid[@otherclass='legalDivType'] = ('part', 'chapter', 'section', 'schedule') must be in a section, &check_ancestor;</assert>
                </rule>
        </pattern>
        
        <pattern id="legislation3">
                <title>Additional legislation tests</title>
                <rule context="db:biblioid[@otherclass='legalDivType'][. = ('section')]" id="legislation-label-context">
                        <assert test="parent::db:info/parent::db:section/@label" id="legislation-label">A biblioid[@otherclass='legalDivType'] = ('section') must be in a section with @label, containing the section number, &check_ancestor;</assert>
                </rule>
        </pattern>
        
        <pattern id="legislation-ids">
                <title>Specific Legislation IDs</title>
                <rule context="db:chapter[db:info/db:biblioid[@otherclass='legalDivType'][. = ('statute')]][db:info/db:title = 'Provisional Collection of Taxes Act 1927']" id="leg-id1">
                        <assert test="@xml:id='PCTA1927'" id="PCTA1927">A legislation chapter with title 'Provisional Collection of Taxes Act 1927' must have id 'PCTA1927', &check_id;</assert>
                </rule>
        </pattern>
        
        <pattern id="legislation-ids2">
                <title>General Legislation IDs</title>
                <rule context="db:section[db:info/db:biblioid[@otherclass='legalDivType']]" id="gen-leg-id-context1">
                        <let name="myID" value="@xml:id"/>
                        <let name="myChapterID" value="ancestor::db:chapter/@xml:id"/>
                        <assert test="starts-with($myID, $myChapterID)" id="legal-section-ids1">A legislation section ID with biblioid[@otherclass='legalDivType'] must start with the chapter ID, &check_id;</assert>
                </rule>
        </pattern>
        
        <pattern id="legislation-ids3">
                <title>Section Legislation IDs</title>
                <rule context="db:section[db:info/db:biblioid[@otherclass='legalDivType'][. = ('section')]]" id="gen-leg-id-context2">
                        <let name="myID" value="@xml:id"/>
                        <let name="myChapterID" value="ancestor::db:chapter/@xml:id"/>
                        <let name="myLabel" value="@label"/>
                        <assert test="starts-with(substring-after($myID, $myChapterID), 's')" id="legal-section-ids2">A legislation section ID with biblioid[@otherclass='legalDivType'] = section must have an 's' after the chapter ID, &check_id;</assert>
                        <assert test="substring-after(substring-after($myID, $myChapterID), 's') = $myLabel" id="legal-section-ids3">A legislation section ID with biblioid[@otherclass='legalDivType'] = section must end with the @label value after the 's', &check_id;</assert>
                </rule>
        </pattern>

        <pattern id="contrib-groups">
<title>Contributor grouping</title>
<rule context="db:info" id="contrib-context">
<report test="count(db:editor) gt 1" id="authorgroup-required-1">There is more than one editor as a direct child of info. Wrap them all in an authorgroup, &check_id;</report>
<report test="count(db:author) gt 1" id="authorgroup-required-2">There is more than one author as a direct child of info. Wrap them all in an authorgroup, &check_id;</report>
<report test="count(db:othercredit[@class='translator']) gt 1" id="authorgroup-required-3">There is more than one othercredit[@role=translator] as a direct child of info. Wrap them all in an authorgroup, &check_id;</report>
</rule>
</pattern>

<pattern id="content-structure">
<title>High-level content checks</title>
<rule context="db:book" id="chunk-context">
<let name="front" value="count(db:part[@role='front'])"/>
<let name="back" value="count(db:part[@role='back'])"/>
<let name="parts" value="count(db:part)"/>
<!-- First one was previously testing this, which is probably not right in all circumstances:
db:info and db:part[@role='front'] and db:part[@role='back'] and not(db:chapter or db:part[db:info/db:mediaobject/db:imageobject[@role='suppressPDF']] or db:part/db:partintro or db:bibliography) -->
<report test="$parts - $front - $back = 0 and (not(db:chapter) and not(db:article))" id="front-back-only">Book contains only front and back matter; is something missing or wrongly structured? &check_id;</report>
<report test="$parts - $front - $back = 1" id="only-one-part" role="warning">There is only one part division (other than front/back), which is unusual. Is that correct? &check_id;</report>
</rule>
<rule context="db:chapter[@label]" id="label-context">
<report test="parent::db:part[@role='front']" role="warning" id="numbered-chapter-front">There is a numbered chapter in the front matter; is that correct? &check_id;</report>
</rule>
</pattern>

<pattern id="publishername">
<title>Specific test(s) for publisher block</title>
<rule context="db:book/db:info/db:biblioset[@role='publisher']/db:publisher/db:publishername | db:bibliomixed//db:publishername" id="pubname-context">
<report test="db:emphasis" id="publishername-emphasis">publishername contains emphasis element, which is incorrect, &check_ancestor;</report>
</rule>
</pattern>

<pattern id="pub-legal">
        <title>Legal-related tests</title>
        <rule context="db:book/db:info/db:biblioset[@role='publisher']/db:publisher/db:publishername[contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'hart') or contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'bloomsbury professional')] | db:book/db:info/db:biblioset[@role='publisher']/db:bibliomisc[@role='imprint'][contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'hart') or contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'bloomsbury professional')]" id="legal-type-context">
                <assert test="ancestor::db:book/db:info/db:biblioid[@otherclass='legalContentType']" id="legal-type-check">Books with a <name/> containing 'Hart' or 'Bloomsbury Professional' must have a book/info/biblioid[@otherclass=legalContentType] &check_ancestor;</assert>
        </rule>
        <rule context="db:orderedlist" id="legal-list-context">
                <report test="if (ancestor::db:book/db:info/db:biblioid[@otherclass='legalContentType']) then 1 else 0" id="legal-lists">An <name/> is not permitted in a legal book (ie one with biblioid[@otherclass='legalContentType']); variablelist must be used and all list labels captured in the data, &check_id;</report>
        </rule>
</pattern>

<pattern id="revisions">
<title>Revisions</title>
<rule context="db:revhistory" id="revhistory-context">
<assert test="parent::db:info/parent::db:book" id="revhistory-location">A revhistory should only be within a book/info</assert>
</rule>
<rule context="db:revision" id="revision-context">
<let name="myDate" value="db:date"/>
<assert test="db:author" id="revision-author">A revision must contain an author; &check_id;</assert>
<assert test="db:revremark" id="revision-revremark">A revision must contain a revremark; &check_id;</assert>
<assert test="db:date castable as xs:date" id="revisions-date-format">A date in a revision must be in YYYY-MM-DD format; &check_id;</assert>
<report test="following-sibling::db:revision[1]/db:date gt $myDate" id="revision-sequence">Revisions must be in date order, most recent first; &check_id;</report>
</rule>
</pattern>

<pattern id="rights">
<title>Rights</title>
<rule context="db:info[not(parent::db:book)]" id="rights-context">
            <report role="information" test="db:releaseinfo[@role='noDigitalRights']" id="no-rights-info">The element <name path="parent::node()"/> does not have digital rights; &check_id;</report>
            <report role="warning" test="db:releaseinfo[@role='noDigitalRights'] and descendant::db:imagedata/@format='application/pdf'" id="no-rights-pdf">The <name/> element has no digital rights, but contains a pdf; is that correct? &check_id;</report>
</rule>
</pattern>

<pattern id="check-label">
<!-- There is no ref to these tests in data specification -->
<title>The @label must only contain real content. If no label is required to be displayed there shouldn't be a @label and the downstream processor should handle that. @label must usually only contain a number</title>
<!-- part, chapter and section can take @role=labelOverRide, but these tests must not apply when it does -->
<rule context="db:footnote[@label] | db:example[@label] | db:figure[@label] | db:footnoteref[@label] | db:appendix[@label] | db:chapter[@label and not(@role='labelOverRide')] | db:part[@label and not(@role='labelOverRide')] | db:section[@label and not(@role='labelOverRide')] | db:bibliodiv[@label] | db:table[@label] | db:equation[@label]" id="footnote-label-context">
&precedingPageNoVariable;
<report test="string-length(@label) = 0" id="empty-label">@label MUST NOT be empty &check_id; &pageNoAndChunkPDF;</report>
<report test="matches(@label, '^\p{Zs}+$')" id="spaces-label">@label MUST NOT contain only space characters; if there is no label, don't add the @label attribute &check_id; &pageNoAndChunkPDF;</report>
<!-- In the following tests we want to see if the label contains text that would normally be generated by the downstream processor -->
<report test="starts-with(translate(@label, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'chapter')" id="chapter-in-label" role="warning">Chunk @label starts with 'chapter', it should normally just be a number (Roman or Arabic), &check_id; &pageNoAndChunkPDF;</report>
<report test="starts-with(translate(@label, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'appendix')" id="appendix-in-label" role="warning">Chunk @label starts with 'appendix', it should normally just be a number (Roman or Arabic), &check_id; &pageNoAndChunkPDF;</report>
<report test="starts-with(translate(@label, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'part')" id="part-in-label" role="warning">Chunk @label starts with 'part', it should normally just be a number (Roman or Arabic), &check_id; &pageNoAndChunkPDF;</report>
<report test="starts-with(translate(@label, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'example')" id="example-in-label" role="warning">Chunk @label starts with 'example', it should normally just be a number (Roman or Arabic), &check_id; &pageNoAndChunkPDF;</report>
<report test="starts-with(translate(@label, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'figure')" id="figure-in-label" role="warning">Chunk @label starts with 'figure', it should normally just be a number (Roman or Arabic), &check_id; &pageNoAndChunkPDF;</report>
<report test="starts-with(translate(@label, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'table')" id="table-in-label" role="warning">Chunk @label starts with 'table', it should normally just be a number (Roman or Arabic), &check_id; &pageNoAndChunkPDF;</report>
<report test="starts-with(translate(@label, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'equation')" id="equation-in-label" role="warning">Chunk @label starts with 'equation', it should normally just be a number (Roman or Arabic), &check_id; &pageNoAndChunkPDF;</report>
<report test="starts-with(translate(@label, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'introduction')" id="introduction-in-label" role="warning">Chunk @label starts with 'introduction', it should normally just be a number (Roman or Arabic), &check_id; &pageNoAndChunkPDF;</report>
<report test="starts-with(translate(@label, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'section')" id="section-in-label" role="warning">Chunk @label starts with 'section', it should normally just be a number (Roman or Arabic), &check_id; &pageNoAndChunkPDF;</report>
<!-- Checks for numbers as words -->
<report test="contains(translate(@label, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'one')" id="one-in-label">Chunk @label contains a number in words (<value-of select="@label"/>), it should just be a number (Roman or Arabic), &check_id; &pageNoAndChunkPDF;</report>
<report test="contains(translate(@label, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'two')" id="two-in-label">Chunk @label contains a number in words (<value-of select="@label"/>), it should just be a number (Roman or Arabic), &check_id; &pageNoAndChunkPDF;</report>
<report test="contains(translate(@label, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'three')" id="three-in-label">Chunk @label contains a number in words (<value-of select="@label"/>), it should just be a number (Roman or Arabic), &check_id; &pageNoAndChunkPDF;</report>
<report test="contains(translate(@label, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'four')" id="four-in-label">Chunk @label contains a number in words (<value-of select="@label"/>), it should just be a number (Roman or Arabic), &check_id; &pageNoAndChunkPDF;</report>
<report test="contains(translate(@label, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'five')" id="five-in-label">Chunk @label contains a number in words (<value-of select="@label"/>), it should just be a number (Roman or Arabic), &check_id; &pageNoAndChunkPDF;</report>
<report test="contains(translate(@label, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'six')" id="six-in-label">Chunk @label contains a number in words (<value-of select="@label"/>), it should just be a number (Roman or Arabic), &check_id; &pageNoAndChunkPDF;</report>
<report test="contains(translate(@label, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'seven')" id="seven-in-label">Chunk @label contains a number in words (<value-of select="@label"/>), it should just be a number (Roman or Arabic), &check_id; &pageNoAndChunkPDF;</report>
<report test="contains(translate(@label, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'eight')" id="eight-in-label">Chunk @label contains a number in words (<value-of select="@label"/>), it should just be a number (Roman or Arabic), &check_id; &pageNoAndChunkPDF;</report>
<report test="contains(translate(@label, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'nine')" id="nine-in-label">Chunk @label contains a number in words (<value-of select="@label"/>), it should just be a number (Roman or Arabic), &check_id; &pageNoAndChunkPDF;</report>
<report test="contains(translate(@label, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'ten')" id="ten-in-label">Chunk @label contains a number in words (<value-of select="@label"/>), it should just be a number (Roman or Arabic), &check_id; &pageNoAndChunkPDF;</report>
<report test="contains(translate(@label, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'eleven')" id="eleven-in-label">Chunk @label contains a number in words (<value-of select="@label"/>), it should just be a number (Roman or Arabic), &check_id; &pageNoAndChunkPDF;</report>
<report test="contains(translate(@label, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'twelve')" id="twelve-in-label">Chunk @label contains a number in words (<value-of select="@label"/>), it should just be a number (Roman or Arabic), &check_id; &pageNoAndChunkPDF;</report>
<report test="contains(translate(@label, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'thirteen')" id="thirteen-in-label">Chunk @label contains a number in words (<value-of select="@label"/>), it should just be a number (Roman or Arabic), &check_id; &pageNoAndChunkPDF;</report>
<report test="contains(translate(@label, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'fifteen')" id="fifteen-in-label">Chunk @label contains a number in words (<value-of select="@label"/>), it should just be a number (Roman or Arabic), &check_id; &pageNoAndChunkPDF;</report>
<report test="contains(translate(@label, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'twenty')" id="twenty-in-label">Chunk @label contains a number in words (<value-of select="@label"/>), it should just be a number (Roman or Arabic), &check_id; &pageNoAndChunkPDF;</report>
</rule>
<rule context="@label" id="label-context-2">
<report id="label-value" role="information" test=".">Value of <name path="parent::node()"/> @label = <value-of select="."/>, &check_ancestor;</report>
<report test="ends-with(., '.')" id="label-end-stop">The @label ends with a stop, which is almost certainly not right, since these should be autogenerated, &check_ancestor;</report>
</rule>
<rule context="db:part" id="part-label-context-3">
&precedingPageNoVariable;
<report test="starts-with(translate(@label, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'part')" id="part-label-issue">A <name/> @label must not start with the string 'part', &check_id; &pageNoAndChunkPDF;</report>
</rule>
<rule context="db:chapter" id="chapter-label-context">
&precedingPageNoVariable;
<report test="starts-with(translate(@label, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'chapter')" id="chapter-label-issue">A <name/> @label must not start with the string 'chapter', &check_id; &pageNoAndChunkPDF;</report>
</rule>
<rule context="db:appendix" id="appendix-label-context">
&precedingPageNoVariable;
<report test="starts-with(translate(@label, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'appendix')" id="appendix-label-issue">A <name/> @label must not start with the string 'appendix', &check_id; &pageNoAndChunkPDF;</report>
</rule>
</pattern>	

<pattern id="label">
        <title>Label over-ride</title>
        <rule context="element()[@role='labelOverRide']" id="override-context">
                <assert test="@label" id="label-required2">A @label is required when there is a @labelOverRide, &check_id;</assert>
        </rule>
</pattern>
<pattern id="appendix-tests">
<title>Appendix tests</title>
<rule context="db:part/db:appendix[1]" id="app1-context">
&precedingPageNoVariable;
<report test="starts-with(db:info/db:title, 'A') and not(@label)" role="warning" id="app-title-a">Appendix title starts with A, should it be the @label? &check_id; &pageNoAndChunkPDF;</report>
<report test="starts-with(db:info/db:title, '1') and not(@label)" role="warning" id="app-title-1">Appendix title starts with 1, should it be the @label? &check_id; &pageNoAndChunkPDF;</report>
</rule>
<rule context="db:part/db:appendix[2]" id="app2-context">
&precedingPageNoVariable;
<report test="starts-with(db:info/db:title, 'B') and not(@label)" role="warning" id="app-title-b">Appendix title starts with B, should it be the @label? &check_id; &pageNoAndChunkPDF;</report>
<report test="starts-with(db:info/db:title, '2') and not(@label)" role="warning" id="app-title-2">Appendix title starts with 2, should it be the @label? &check_id; &pageNoAndChunkPDF;</report>
</rule>
<rule context="db:part/db:appendix[3]" id="app3-context">
&precedingPageNoVariable;
<report test="starts-with(db:info/db:title, 'C') and not(@label)" role="warning" id="app-title-c">Appendix title starts with C, should it be the @label? &check_id; &pageNoAndChunkPDF;</report>
<report test="starts-with(db:info/db:title, '3') and not(@label)" role="warning" id="app-title-3">Appendix title starts with 3, should it be the @label? &check_id; &pageNoAndChunkPDF;</report>
</rule>
<rule context="db:part/db:appendix[4]" id="app4-context">
&precedingPageNoVariable;
<report test="starts-with(db:info/db:title, 'D') and not(@label)" role="warning" id="app-title-d">Appendix title starts with D, should it be the @label? &check_id; &pageNoAndChunkPDF;</report>
<report test="starts-with(db:info/db:title, '4') and not(@label)" role="warning" id="app-title-4">Appendix title starts with 4, should it be the @label? &check_id; &pageNoAndChunkPDF;</report>
</rule>
<rule context="db:part/db:appendix[5]" id="app5-context">
&precedingPageNoVariable;
<report test="starts-with(db:info/db:title, 'E') and not(@label)" role="warning" id="app-title-e">Appendix title starts with E, should it be the @label? &check_id; &pageNoAndChunkPDF;</report>
<report test="starts-with(db:info/db:title, '5') and not(@label)" role="warning" id="app-title-5">Appendix title starts with 5, should it be the @label? &check_id; &pageNoAndChunkPDF;</report>
</rule>
<rule context="db:part/db:appendix[6]" id="app6-context">
&precedingPageNoVariable;
<report test="starts-with(db:info/db:title, 'F') and not(@label)" role="warning" id="app-title-f">Appendix title starts with F, should it be the @label? &check_id; &pageNoAndChunkPDF;</report>
<report test="starts-with(db:info/db:title, '6') and not(@label)" role="warning" id="app-title-6">Appendix title starts with 6, should it be the @label? &check_id; &pageNoAndChunkPDF;</report>
</rule>
<rule context="db:part/db:appendix[7]" id="app7-context">
&precedingPageNoVariable;
<report test="starts-with(db:info/db:title, 'G') and not(@label)" role="warning" id="app-title-g">Appendix title starts with G, should it be the @label? &check_id; &pageNoAndChunkPDF;</report>
<report test="starts-with(db:info/db:title, '7') and not(@label)" role="warning" id="app-title-7">Appendix title starts with 7, should it be the @label? &check_id; &pageNoAndChunkPDF;</report>
</rule>
<rule context="db:part/db:appendix[8]" id="app8-context">
&precedingPageNoVariable;
<report test="starts-with(db:info/db:title, 'H') and not(@label)" role="warning" id="app-title-h">Appendix title starts with H, should it be the @label? &check_id; &pageNoAndChunkPDF;</report>
<report test="starts-with(db:info/db:title, '8') and not(@label)" role="warning" id="app-title-8">Appendix title starts with 8, should it be the @label? &check_id; &pageNoAndChunkPDF;</report>
</rule>
<rule context="db:part/db:appendix[9]" id="app9-context">
&precedingPageNoVariable;
<report test="starts-with(db:info/db:title, 'I') and not(@label)" role="warning" id="app-title-i">Appendix title starts with I, should it be the @label? &check_id; &pageNoAndChunkPDF;</report>
<report test="starts-with(db:info/db:title, '9') and not(@label)" role="warning" id="app-title-9">Appendix title starts with 9, should it be the @label? &check_id; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

<pattern id="other-biblioid">
<title>Test for values of @otherclass on biblioid</title>
<rule context="db:biblioid[@class='other']" id="bibid-other-context">
        <assert test="@otherclass='schemaVersion' or @otherclass='schematronVersion' or @otherclass='hasOnlineResources' or @otherclass='fiction' or @otherclass='suppressChapterNumeration' or @otherclass='refNo' or @otherclass='biblioType' or @otherclass='allBiblioItemsUnlinked' or @otherclass='formalparaNumeric' or @otherclass='taxonRank' or @otherclass='fpaArticleType' or @otherclass='legalContentType' or @otherclass='bedArticleType' or @otherclass='specialBookType' or @otherclass='DOInotRequired' or @otherclass='courtCode' or @otherclass='shortCourtName' or @otherclass='decisionDate' or @otherclass='shortCaseName' or @otherclass='caseCitation' or @otherclass='legalJurisdiction' or @otherclass='legalDivType'"  id="non-permitted-otherclass">biblioid/@otherclass does not have one of the permitted values (value = <value-of select="@otherclass"/>), &check_ancestor;</assert>
</rule>
</pattern>

<pattern id="series">
<title>Book-level series metadata tests</title>
<rule context="db:book/db:info[not(db:biblioid[@otherclass='fiction'] = '1')]" id="book-series-context">
<assert test="descendant::db:title[@role='series']" role="warning" id="no-series">Book does not contain a series name, OK? A high proportion of academic titles should have one, so please check the text in the pdf prelims</assert>
</rule>
<rule context="db:biblioset[@role='series']" id="series-context">
<assert test="parent::db:info/parent::db:book | parent::db:cover[@role='series']" id="series-location">A biblioset[@role=series] must be a child of either the book/info or a cover[@role=series], &check_id;</assert>
<assert test="db:title" id="series-title">A series group MUST contain a series title. &check_id;</assert>
<report test="contains(db:title, 'BCP Egyptology')" id="previous-series-1">Series name contains "BCP Egyptology", this should be the previousTitle, and the current title is "Bloomsbury Egyptology", &check_id;</report>
<report test="contains(db:title, 'Berg New Media Series')" id="previous-series-2">Series name contains "Berg New Media Series", this should be the previousTitle, and the current title is "Bloomsbury New Media Series", &check_id;</report>
<report test="contains(db:title, 'Continuum Advances in Religious Studies')" id="previous-series-3">Series name contains "Continuum Advances in Religious Studies", this should be the previousTitle, and the current title is "Bloomsbury Advances in Religious Studies", &check_id;</report>
<report test="contains(db:title, 'Continuum Advances in Semiotics')" id="previous-series-4">Series name contains "Continuum Advances in Semiotics", this should be the previousTitle, and the current title is "Bloomsbury Advances in Semiotics", &check_id;</report>
<report test="contains(db:title, 'Continuum Advances in Translation')" id="previous-series-5">Series name contains "Continuum Advances in Translation", this should be the previousTitle, and the current title is "Bloomsbury Advances in Translation", &check_id;</report>
<report test="contains(db:title, 'Continuum Aesthetics')" id="previous-series-6">Series name contains "Continuum Aesthetics", this should be the previousTitle, and the current title is "Bloomsbury Aesthetics", &check_id;</report>
<report test="contains(db:title, 'Continuum Companions')" id="previous-series-7">Series name contains "Continuum Companions", this should be the previousTitle, and the current title is "Bloomsbury Companions", &check_id;</report>
<report test="contains(db:title, 'Continuum Contemporary American Thinkers')" id="previous-series-8">Series name contains "Continuum Contemporary American Thinkers", this should be the previousTitle, and the current title is "Bloomsbury Contemporary American Thinkers", &check_id;</report>
<report test="contains(db:title, 'Continuum Critical Introductions to Linguistics')" id="previous-series-9">Series name contains "Continuum Critical Introductions to Linguistics", this should be the previousTitle, and the current title is "Bloomsbury Critical Introductions to Linguistics", &check_id;</report>
<report test="contains(db:title, 'Continuum Discourse')" id="previous-series-10">Series name contains "Continuum Discourse", this should be the previousTitle, and the current title is "Bloomsbury Discourse", &check_id;</report>
<report test="contains(db:title, 'Continuum Education Handbooks')" id="previous-series-11">Series name contains "Continuum Education Handbooks", this should be the previousTitle, and the current title is "Bloomsbury Education Handbooks", &check_id;</report>
<report test="contains(db:title, 'Continuum Ethics')" id="previous-series-12">Series name contains "Continuum Ethics", this should be the previousTitle, and the current title is "Bloomsbury Ethics", &check_id;</report>
<report test="contains(db:title, 'Continuum History of Philosophy')" id="previous-series-13">Series name contains "Continuum History of Philosophy", this should be the previousTitle, and the current title is "Bloomsbury History of Philosophy", &check_id;</report>
<report test="contains(db:title, 'Continuum Impacts')" id="previous-series-14">Series name contains "Continuum Impacts", this should be the previousTitle, and the current title is "Impacts", &check_id;</report>
<report test="contains(db:title, 'Continuum Intelligence Studies')" id="previous-series-15">Series name contains "Continuum Intelligence Studies", this should be the previousTitle, and the current title is "Bloomsbury Intelligence Studies", &check_id;</report>
<report test="contains(db:title, 'Continuum One Hundreds')" id="previous-series-16">Series name contains "Continuum One Hundreds", this should be the previousTitle, and the current title is "100 Ideas", &check_id;</report>
<report test="contains(db:title, 'Continuum Philosophy Dictionaries')" id="previous-series-17">Series name contains "Continuum Philosophy Dictionaries", this should be the previousTitle, and the current title is "Bloomsbury Philosophy Dictionaries", &check_id;</report>
<report test="contains(db:title, 'Continuum Political Philosophy')" id="previous-series-18">Series name contains "Continuum Political Philosophy", this should be the previousTitle, and the current title is "Bloomsbury Political Philosophy", &check_id;</report>
<report test="contains(db:title, 'Continuum Renaissance Drama')" id="previous-series-19">Series name contains "Continuum Renaissance Drama", this should be the previousTitle, and the current title is "Arden Early Modern Drama Guides", &check_id;</report>
<report test="contains(db:title, 'Continuum Research Methods')" id="previous-series-20">Series name contains "Continuum Research Methods", this should be the previousTitle, and the current title is "Bloomsbury Research Methods", &check_id;</report>
<report test="contains(db:title, 'Continuum Shakespeare Dictionaries')" id="previous-series-21">Series name contains "Continuum Shakespeare Dictionaries", this should be the previousTitle, and the current title is "Arden Shakespeare Dictionaries", &check_id;</report>
<report test="contains(db:title, 'Continuum Sources in Ancient History')" id="previous-series-22">Series name contains "Continuum Sources in Ancient History", this should be the previousTitle, and the current title is "Bloomsbury Sources in Ancient History", &check_id;</report>
<report test="contains(db:title, 'Continuum Studies in American Philosophy')" id="previous-series-23">Series name contains "Continuum Studies in American Philosophy", this should be the previousTitle, and the current title is "Bloomsbury Studies in American Philosophy", &check_id;</report>
<report test="contains(db:title, 'Continuum Studies in Ancient Philosophy')" id="previous-series-24">Series name contains "Continuum Studies in Ancient Philosophy", this should be the previousTitle, and the current title is "Bloomsbury Studies in Ancient Philosophy", &check_id;</report>
<report test="contains(db:title, 'Continuum Studies in Classical Reception')" id="previous-series-25">Series name contains "Continuum Studies in Classical Reception", this should be the previousTitle, and the current title is "Bloomsbury Studies in Classical Reception", &check_id;</report>
<report test="contains(db:title, 'Continuum Studies in Contemporary North American Fiction')" id="previous-series-26">Series name contains "Continuum Studies in Contemporary North American Fiction", this should be the previousTitle, and the current title is "Bloomsbury Studies in Contemporary North American Fiction", &check_id;</report>
<report test="contains(db:title, 'Continuum Studies in Continental Philosophy')" id="previous-series-27">Series name contains "Continuum Studies in Continental Philosophy", this should be the previousTitle, and the current title is "Bloomsbury Studies in Continental Philosophy", &check_id;</report>
<report test="contains(db:title, 'Continuum Studies in Jewish Thought')" id="previous-series-28">Series name contains "Continuum Studies in Jewish Thought", this should be the previousTitle, and the current title is "Bloomsbury Studies in Jewish Thought", &check_id;</report>
<!--<report test="contains(db:title, 'Bloomsbury Studies in Jewish Thought') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-28a">Series name contains "Bloomsbury Studies in Jewish Thought" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Studies in Jewish Thought", &check_id;</report>-->
<report test="contains(db:title, 'Continuum Studies in Military History')" id="previous-series-29">Series name contains "Continuum Studies in Military History", this should be the previousTitle, and the current title is "Bloomsbury Studies in Military History", &check_id;</report>
<report test="matches(db:title, '^Continuum Studies in Philosophy$')" id="previous-series-30">Series name contains "Continuum Studies in Philosophy", this should be the previousTitle, and the current title is "Bloomsbury Studies in Philosophy", &check_id;</report>
<report test="contains(db:title, 'Continuum Studies in Philosophy of Religion')" id="previous-series-31">Series name contains "Continuum Studies in Philosophy of Religion", this should be the previousTitle, and the current title is "Bloomsbury Studies in Philosophy of Religion", &check_id;</report>
<report test="contains(db:title, 'Continuum Studies in Political Philosophy')" id="previous-series-32">Series name contains "Continuum Studies in Political Philosophy", this should be the previousTitle, and the current title is "Bloomsbury Studies in Political Philosophy", &check_id;</report>
<report test="contains(db:title, 'Continuum Studies in the City')" id="previous-series-33">Series name contains "Continuum Studies in the City", this should be the previousTitle, and the current title is "Bloomsbury Studies in the City", &check_id;</report>
<report test="contains(db:title, 'Continuum Studies in Theoretical Linguistics')" id="previous-series-34">Series name contains "Continuum Studies in Theoretical Linguistics", this should be the previousTitle, and the current title is "Bloomsbury Studies in Theoretical Linguistics", &check_id;</report>
<report test="contains(db:title, 'Continuum Studies in Translation')" id="previous-series-35">Series name contains "Continuum Studies in Translation", this should be the previousTitle, and the current title is "Bloomsbury Studies in Translation", &check_id;</report>
<report test="contains(db:title, 'The Continuum Decades Series')" id="previous-series-36">Series name contains "The Continuum Decades Series", this should be the previousTitle, and the current title is "The Decades Series", &check_id;</report>
<!-- Check if new series title in old book but no previous title -->
<report test="contains(db:title, 'Bloomsbury Egyptology') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-1a">Series name contains "Bloomsbury Egyptology" and pubdate before 2013 but does not have a previousTitle, which should be "BCP Egyptology", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury New Media Series') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-2a">Series name contains "Bloomsbury New Media Series" and pubdate before 2013 but does not have a previousTitle, which should be "Berg New Media Series", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury Advances in Religious Studies') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-3a">Series name contains "Bloomsbury Advances in Religious Studies" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Advances in Religious Studies", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury Advances in Semiotics') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-4a">Series name contains "Bloomsbury Advances in Semiotics" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Advances in Semiotics", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury Advances in Translation') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-5a">Series name contains "Bloomsbury Advances in Translation" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Advances in Translation", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury Aesthetics') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-6a">Series name contains "Bloomsbury Aesthetics" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Aesthetics", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury Companions') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-7a">Series name contains "Bloomsbury Companions" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Companions", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury Contemporary American Thinkers') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-8a">Series name contains "Bloomsbury Contemporary American Thinkers" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Contemporary American Thinkers", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury Critical Introductions to Linguistics') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-9a">Series name contains "Bloomsbury Critical Introductions to Linguistics" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Critical Introductions to Linguistics", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury Discourse') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-10a">Series name contains "Bloomsbury Discourse" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Discourse", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury Education Handbooks') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-11a">Series name contains "Bloomsbury Education Handbooks" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Education Handbooks", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury Ethics') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-12a">Series name contains "Bloomsbury Ethics" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Ethics", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury History of Philosophy') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-13a">Series name contains "Bloomsbury History of Philosophy" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum History of Philosophy", &check_id;</report>
<report test="matches(db:title, '^Impacts$') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-14a">Series name contains "Impacts" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Impacts", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury Intelligence Studies') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-15a">Series name contains "Bloomsbury Intelligence Studies" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Intelligence Studies", &check_id;</report>
<report test="contains(db:title, '100 Ideas') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-16a">Series name contains "100 Ideas" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum One Hundreds", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury Philosophy Dictionaries') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-17a">Series name contains "Bloomsbury Philosophy Dictionaries" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Philosophy Dictionaries", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury Political Philosophy') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-18a">Series name contains "Bloomsbury Political Philosophy" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Political Philosophy", &check_id;</report>
<report test="contains(db:title, 'Arden Early Modern Drama Guides') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-19a">Series name contains "Arden Early Modern Drama Guides" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Renaissance Drama", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury Research Methods') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-20a">Series name contains "Bloomsbury Research Methods" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Research Methods", &check_id;</report>
<report test="contains(db:title, 'Arden Shakespeare Dictionaries') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-21a">Series name contains "Arden Shakespeare Dictionaries" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Shakespeare Dictionaries", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury Sources in Ancient History') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-22a">Series name contains "Bloomsbury Sources in Ancient History" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Sources in Ancient History", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury Studies in American Philosophy') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-23a">Series name contains "Bloomsbury Studies in American Philosophy" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Studies in American Philosophy", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury Studies in Ancient Philosophy') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-24a">Series name contains "Bloomsbury Studies in Ancient Philosophy" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Studies in Ancient Philosophy", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury Studies in Classical Reception') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-25a">Series name contains "Bloomsbury Studies in Classical Reception" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Studies in Classical Reception", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury Studies in Contemporary North American Fiction') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-26a">Series name contains "Bloomsbury Studies in Contemporary North American Fiction" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Studies in Contemporary North American Fiction", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury Studies in Continental Philosophy') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-27a">Series name contains "Bloomsbury Studies in Continental Philosophy" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Studies in Continental Philosophy", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury Studies in Jewish Thought') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-28a">Series name contains "Bloomsbury Studies in Jewish Thought" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Studies in Jewish Thought", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury Studies in Military History') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-29a">Series name contains "Bloomsbury Studies in Military History" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Studies in Military History", &check_id;</report>
<report test="matches(db:title, '^Bloomsbury Studies in Philosophy$') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-30a">Series name contains "Bloomsbury Studies in Philosophy" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Studies in Philosophy", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury Studies in Philosophy of Religion') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-31a">Series name contains "Bloomsbury Studies in Philosophy of Religion" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Studies in Philosophy of Religion", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury Studies in Political Philosophy') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-32a">Series name contains "Bloomsbury Studies in Political Philosophy" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Studies in Political Philosophy", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury Studies in the City') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-33a">Series name contains "Bloomsbury Studies in the City" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Studies in the City", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury Studies in Theoretical Linguistics') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-34a">Series name contains "Bloomsbury Studies in Theoretical Linguistics" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Studies in Theoretical Linguistics", &check_id;</report>
<report test="contains(db:title, 'Bloomsbury Studies in Translation') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-35a">Series name contains "Bloomsbury Studies in Translation" and pubdate before 2013 but does not have a previousTitle, which should be "Continuum Studies in Translation", &check_id;</report>
<report test="contains(db:title, 'The Decades Series') and (number(ancestor::db:info/db:pubdate[@role='published']) lt 2013) and not(db:bibliomisc[@role='previousTitle'])" id="previous-series-36a">Series name contains "The Decades Series" and pubdate before 2013 but does not have a previousTitle, which should be "The Continuum Decades Series", &check_id;</report>
<!-- Need to ensure that exact forms of series names are used -->
        <assert id="series-name-list" test="db:title = ('10 Minute Spelling Tests', '100 Great Recipes', '100 Ideas for Teachers', '100 Ideas for the Early Years', '100% New Developing Literacy', '100% New Developing Mathematics', '101 Drills', '101 Essential Lists', '101 Things', '21st Century Genre Fiction', '33 1/3', '50 Fantastic Things', '50 Fantastic...', '50 Ways to Improve Your...', '69 series', 'A &amp; C Black Assembly Packs', 'A &amp; C Black Mini-musicals', 'A &amp; C Black Musical Licences', 'A &amp; C Black Musicals', 'A &amp; C Black Whiteboard Songs', 'A Court of Thorns and Roses', 'A Good Country', 'A Konrad Simonsen Thriller', 'A Lesson For Every Day', 'A Maggie Brooklyn Mystery', 'A Modern History of Politics and Violence', 'A Newbery Honor book', 'A Perfect Chemistry Novel', 'A Robyn Hoodlum Adventure', 'A Spike Sanguinetti Novel', 'A User''s Guide to... Series', 'A Whole Nother Story', 'ACB Originals', 'Abigail Iris', 'Abitare Annuals', 'Abracadabra Brass ', 'Abracadabra Guitar', 'Abracadabra Piano', 'Abracadabra Recorder', 'Abracadabra Strings', 'Abracadabra Strings Beginners', 'Abracadabra Woodwind', 'Access to Knowledge', 'Ace Place', 'Across the Curriculum: Geography', 'Across the Curriculum: Science', 'Active Every Day', 'Activity Books For Boys', 'Activity Books For Girls', 'Adlard Coles Book of', 'Adlard Coles Manuals', 'Adlard Coles Maritime Classics', 'Advances in Applied Linguistics', 'Advances in Digital Language Learning and Teaching', 'Advances in Experimental Philosophy', 'Advances in Instructed Second Language Acquisition Research', 'Advances in Sociolinguistics', 'Advances in Stylistics', 'Adventures Abroad', 'Adventures of a Young Sailor', 'Affirming Catholicism', 'African American Religious Thought and Life', 'Aga and Range Cookbooks', 'Air Vanguard', 'Aircraft of the Aces', 'Akimbo', 'Alfred Kropp', 'Almond Press Individual Titles', 'Also Known As', 'American Schools of Oriental Research Excavation Reports', 'American Schools of Oriental Research Monographs', 'An Araminta Spookie Adventure', 'An I.Q book', 'An Unofficial Gamer’s Adventure', 'An explorefaith.org Book', 'Anatomy', 'Anatomy of The Ship', 'Ancient Commentators on Aristotle', 'Ancients in Action', 'Anglican Association of Biblical Scholars Study Series', 'Anglo-Catalan Society', 'Anglo-Russian Affinities', 'Animal Tales', 'Animals Sticker Activity Books', 'Animals on the Edge', 'Annabelle Unleashed', 'Anthrozoos', 'Applied Theatre', 'Approaches to Digital Game Studies', 'Archaeological Histories', 'Archaeology of Medieval Britain', 'Architecture and Culture', 'Arden Critical Companions', 'Arden Early Modern Drama', 'Arden Early Modern Drama Guides', 'Arden Shakespeare', 'Arden Shakespeare Dictionaries', 'Arden Shakespeare Library', 'Arden Shakespeare The State of Play', 'Arden Student Guides', 'Arden Student Skills: Language and Writing', 'Arnold History of Britain', 'Arnold History of Europe', 'Arnold Readers in History', 'Arnold Student Reference', 'Art Express', 'Art in Translation', 'Artist Questions Answered', 'Artist''s Workshop', 'Asian Cinema', 'Assembly Today', 'Assembly Tomorrow', 'Assessing Pupils'' Progress', 'Association of Social Anthropologists Monographs', 'Athlete vs. Mathlete', 'Athlone Contemporary European Thinkers', 'Athlone French Poets', 'Athlone Publications in Egyptology &amp; Ancient Near Eastern Studies', 'Athlone Renaissance Library', 'Audition Speeches', 'BCP Egyptology', 'BCPaperbacks', 'Baby &amp; Beyond', 'Backstage', 'Basics Advertising', 'Basics Animation', 'Basics Architecture', 'Basics Creative Photography', 'Basics Design', 'Basics Fashion Design', 'Basics Fashion Management', 'Basics Filmmaking', 'Basics Graphic Design', 'Basics Illustration', 'Basics Interactive Design', 'Basics Interior Architecture', 'Basics Interior Design', 'Basics Landscape Architecture', 'Basics Marketing ', 'Basics Photography', 'Basics Product Design', 'Basics Textile Design', 'Basics Typography', 'Basics of Sculpture', 'Bedside, Bathtub &amp; Armchair Companions', 'Berg European Studies', 'Berg French Studies', 'Berg Monographs in German Literature', 'Berg New Media', 'Best Handwriting', 'Beyond Criticism', 'Bible and Literature', 'Bible and Postcolonialism', 'Biblical Guides', 'Biblical Languages: Greek', 'Biblical Languages: Hebrew', 'Biblical Seminar', 'Big Picture', 'Biography and Autobiography', 'Birds of Africa', 'Birdwatcher''s Guides', 'Birmingham University Semitic Study Aids', 'Birmingham War Studies', 'Black Atlantic', 'Black Cats', 'Black Magic', 'Black''s Nature Guides', 'Black''s New Testament Commentaries', 'Black''s Sketchbooks', 'Bloomsbury Academic Collections: Biblical Studies', 'Bloomsbury Academic Collections: Economics', 'Bloomsbury Academic Collections: English Literary Criticism', 'Bloomsbury Academic Collections: Japan', 'Bloomsbury Academic Collections: Philosophy', 'Bloomsbury Adaptation Histories', 'Bloomsbury Advances in Critical Discourse Studies', 'Bloomsbury Advances in Religious Studies', 'Bloomsbury Advances in Semiotics', 'Bloomsbury Advances in Translation', 'Bloomsbury Aesthetics', 'Bloomsbury CPD Library', 'Bloomsbury Classics in Linguistics', 'Bloomsbury Comics Studies', 'Bloomsbury Companions', 'Bloomsbury Contemporary American Thinkers', 'Bloomsbury Critical Introductions to Contemporary Epistemology', 'Bloomsbury Critical Introductions to Contemporary Metaphysics', 'Bloomsbury Critical Introductions to Linguistics', 'Bloomsbury Curriculum Basics', 'Bloomsbury Discourse', 'Bloomsbury Educational Editions', 'Bloomsbury Education Handbooks', 'Bloomsbury Egyptology', 'Bloomsbury Ethics', 'Bloomsbury Handbooks in Religion', 'Bloomsbury History of Philosophy', 'Bloomsbury Intelligence Studies', 'Bloomsbury Library of Educational Thought', 'Bloomsbury New Media Series', 'Bloomsbury Perspectives on Children''s Literature', 'Bloomsbury Philosophy Dictionaries', 'Bloomsbury Political Philosophy', 'Bloomsbury Research Handbooks in Asian Philosophy', 'Bloomsbury Research Methods', 'Bloomsbury Research Methods for Education', 'Bloomsbury Research Skills for History', 'Bloomsbury Research in Political Philosophy', 'Bloomsbury Revelations', 'Bloomsbury Shinto Studies', 'Bloomsbury Sources in Ancient History', 'Bloomsbury Studies in American Philosophy', 'Bloomsbury Studies in Ancient Philosophy', 'Bloomsbury Studies in Central and East European History', 'Bloomsbury Studies in Classical Reception', 'Bloomsbury Studies in Contemporary North American Fiction', 'Bloomsbury Studies in Continental Philosophy', 'Bloomsbury Studies in Global Ethics', 'Bloomsbury Studies in Jewish Thought', 'Bloomsbury Studies in Military History', 'Bloomsbury Studies in Philosophy', 'Bloomsbury Studies in Philosophy of Religion', 'Bloomsbury Studies in Religion and Popular Music', 'Bloomsbury Studies in Theoretical Linguistics', 'Bloomsbury Studies in Translation', 'Bloomsbury Studies in the Aristotelian Tradition', 'Bloomsbury Studies in the City', 'Bloomsbury Topics in Contemporary North American Literature', 'Body In Action', 'Bolt Action', 'Books of Bayern', 'Brief Histories', 'Britain and Europe', 'British Studies in Applied Linguistics', 'British Theatre Companies: From Fringe to Mainstream', 'Business', 'Business on a Shoestring', 'Business, Culture and Change', 'Busy Practitioner', 'CIVICUS Global Study of Civil Society', 'Cambridge Yearbook of European Legal Studies', 'Camera Craft', 'Campaign', 'Campaign for Learning', 'Carrying on in Key Stage 1', 'Cartoon History', 'Celebrations', 'Ceramics Handbooks', 'Chameleons', 'Character Studies', 'Chatham House Papers', 'Check Your Vocabulary', 'Chillers', 'China and International Economic Law', 'Choices', 'Christian Mission &amp; Modern Culture', 'Christmas Maths', 'Church Dogmatics', 'Civil Justice Systems', 'Classic Commentaries', 'Classic Criticism', 'Classic Reprint Series', 'Classical Diaspora', 'Classical Dramatists', 'Classical Essays', 'Classical Inter/Faces', 'Classical Life and Letters', 'Classical Literature and Society', 'Classical Studies', 'Classical World', 'Classmates', 'Classroom Starters and Plenaries', 'Clifford Chance Lectures', 'Coastal Guides from the Air', 'Collected Works of M.A.K. Halliday', 'Colour Graffix', 'Colour Jets', 'Colouring Activity Books', 'Columbia London Law Series', 'Combat', 'Combat Aircraft', 'Comix', 'Communications Law', 'Companion to the Qumran Scrolls', 'Companions to Greek and Roman Tragedy', 'Comparative Genocide', 'Comparative Islamic Studies', 'Comparative Media, Communication and Culture', 'Compass Series', 'Complete Guides', 'Constitutional Systems of the World', 'Constitutional Systems of the World: Thematic Studies', 'Construction Newsletter', 'Contemporary Anarchist Studies', 'Contemporary Applied Linguistics', 'Contemporary Christian Culture', 'Contemporary Christian Insights', 'Contemporary Classics in Children''s Literature', 'Contemporary Critical Perspectives', 'Contemporary Dramatists', 'Contemporary European Studies', 'Contemporary Food Studies: Economy, Culture and Politics', 'Contemporary Issues in Education Studies', 'Contemporary Issues in Museum Culture', 'Contemporary Studies in Corporate Law', 'Contemporary Studies in Linguistics', 'Contexts', 'Continuum Advances in Religious Studies', 'Continuum Advances in Semiotics', 'Continuum Advances in Translation', 'Continuum Biblical Studies', 'Continuum Classic Texts', 'Continuum Contemporaries', 'Continuum Contemporary American Thinkers', 'Continuum Critical Introductions to Linguistics', 'Continuum Discourse', 'Continuum Education Handbooks', 'Continuum Empirical Studies in Education', 'Continuum Ethics', 'Continuum Histories', 'Continuum Icons', 'Continuum Impacts', 'Continuum Intelligence Studies', 'Continuum Library of Educational Thought', 'Continuum Literary Studies', 'Continuum One Hundreds', 'Continuum Philosophy Dictionaries', 'Continuum Reception Studies', 'Continuum Renaissance Drama Guides', 'Continuum Research Methods', 'Continuum Resources in Religion and Political Culture', 'Continuum Shakespeare Dictionaries', 'Continuum Shakespeare Studies', 'Continuum Studies in American Philosophy', 'Continuum Studies in Ancient Philosophy', 'Continuum Studies in British Philosophy', 'Continuum Studies in Classical Reception', 'Continuum Studies in Continental Philosophy', 'Continuum Studies in Eastern Philosophies', 'Continuum Studies in Educational Research', 'Continuum Studies in Jewish Thought', 'Continuum Studies in Lifelong Learning', 'Continuum Studies in Philosophy', 'Continuum Studies in Philosophy of Religion', 'Continuum Studies in Political Philosophy', 'Continuum Studies in Religion and Political Culture', 'Continuum Studies in Research in Education', 'Continuum Studies in Theoretical Linguistics', 'Continuum Studies in Translation', 'Continuum Studies in the City', 'Controversies in the Study of Religion', 'Conway Classics', 'Conway Compass', 'Conway Maritime Modeller''s Series', 'Conway Plan Portfolios', 'Conway''s History of Sail', 'Conway''s History of the Ship', 'Conway''s Merchant Marine &amp; Maritime History', 'Conway''s Naval History After 1850', 'Conway''s Plan Portfolio', 'Conway''s Ship Modelling', 'Conway''s Ship Types', 'Copenhagen International Seminar', 'Copy and Cut', 'Core Tax Annuals', 'Corpus and Discourse', 'Course Companions in the History of Medicine', 'Crackers', 'Craft Workshop', 'Create Your Own', 'Creative Careers', 'Creative Core', 'Creative Painting', 'Criminal Law Library', 'Criminal Practice', 'Critical Adventures in New Media', 'Critical Companions', 'Critical Pedagogy Today', 'Critical Performances', 'Critical Political Studies', 'Critical Powers', 'Critical Research in Material Culture', 'Critical Scripts', 'Critical Stages', 'Critical Studies in Russian Literature', 'Critical Theory and Contemporary Society', 'Cross-Cultural Perspectives on Women', 'Crossing Ebenezer Creek', 'Crucible Plays', 'Crunchbone Castle Chronicles', 'Cultural Memory and History in Antiquity', 'Cultural Politics', 'Cultural Studies in Practice', 'Cultural and Social History', 'Culture Machine', 'Cultures of Consumption Series', 'Cultures of Early Modern Europe', 'Curriculum Charts', 'Curtain Up', 'D &amp; T Workshop', 'Dance Divas', 'Dance of Shadows', 'Dancing to Music', 'Dark Hunter', 'Dark Lord', 'Dark Osprey', 'Daystar Devotions', 'Dealing with Feelings', 'Debates in Archaeology', 'Debates in World History', 'Debating Law', 'Decades of Modern British Playwriting', 'Decisions of the Arbitration Panel for In Rem Restitution', 'Declaration', 'Defences in Private Law', 'Deleuze Encounters', 'Design Philosophy Papers', 'Design Your Own...', 'Design and Culture', 'Design and Make', 'Design, Histories, Futures', 'Developing Citizenship', 'Developing French', 'Developing History', 'Developing Literacy', 'Developing Numeracy', 'Developing Science', 'Developing Spanish', 'Diaries, Letters and Essays', 'Dictionary Classical Hebrew', 'Digital Photography', 'Dino Stories', 'Directors Handbook', 'Documents in International Law', 'Doing Theology', 'Dragon Slippers', 'DragonChild', 'Dragonborn', 'Draw Books', 'Dress and Fashion Research', 'Dress, Body, Culture', 'Duel', 'Duke de Richleau', 'E-design', 'EU Law in the Member States', 'EX:CENTRICS', 'Early Years Library', 'Earlybirds', 'Easier English', 'Ecclesiological Investigations', 'Education Around the World', 'Education and Digital Technology', 'Education as a Humanitarian Response', 'Edward Schillebeeckx Collected Works', 'Egyptian Tales', 'Elements of Dress', 'Elite', 'Elite Performance', 'Ellie McDoodle', 'Emory Studies in Early Christianity', 'Empire in Asia', 'Enchanted Sisters', 'Encounters: Experience and Anthropological Knowledge', 'Encyclopedia of Popular Music of the World', 'English', 'English Today', 'Environmental Cultures', 'Epica', 'Epworth Commentary', 'Essays in European Law', 'Essential FE Toolkit', 'Essential FM Reports', 'Essential Glossary', 'Essential Guides', 'Essential Histories', 'Essential Reference', 'Ethnicity and Identity', 'European Academy of Legal Theory', 'European Community Law', 'European Competition Law Annual', 'European and National Constitutional Law', 'Europe’s Legacy in the Modern World', 'Evergreens', 'Exciting ICT', 'Exercise Your Way to Health', 'Explorations in Anthropology', 'Extreme!', 'Factor 4', 'Faerie Wars Chronicles', 'Faith and Scholarship Colloquies', 'Faithful Servants', 'Family Court Reports', 'Fashion Practice', 'Fashion Theory', 'Feminist Companion to the Bible', 'Feminist Companion to the New Testament and Early Christian Writings', 'Festivals Across the Year', 'Field Guide To', 'Film Genres', 'Film Theory in Practice', 'Financial Intelligence', 'Finnish Yearbook of International Law', 'First Animal Encyclopedia', 'Fitness Professionals', 'Fitness Trainers', 'Fizzlebert Stump', 'Flashbacks', 'Fletcher Smith P.I.', 'Focus Bible Study', 'Focus on the Prayer Book: An Adult Study', 'Food Safety Newsletter', 'Food, Culture and Society', 'Fordham Intellectual Property Law and Policy Annual', 'Foundations', 'Foundations in Media', 'Freckleface Strawberry', 'French Regional Studies', 'French Studies in International Law', 'French Texts', 'Frontiers of International Education', 'Fundamentals', 'Fundamentals,Required Reading Range', 'Future Schools', 'GCSE Student Editions', 'GCSE Student Guides', 'Geographers: Biobibliographical Studies', 'Geography Today', 'German Historical Perspectives', 'German Library', 'German Studies', 'German Texts', 'Get Fit', 'Get Ready', 'Get Set! Piano', 'Get them Thinking like …', 'Getting the Buggers', 'Glass Handbooks', 'Global Exploitation Cinemas', 'Global Food History', 'Global Issues', 'Global Sport Cultures', 'Globalizing Sport Studies', 'Go Facts: Animals', 'Go Facts: Environmental Issues', 'Go Facts: Food', 'Go Facts: Healthy Bodies', 'Go Facts: Natural Disasters', 'Go Facts: Natural Environments', 'Go Facts: Oceans', 'Go Facts: Physical Science', 'Go Facts: Plants', 'Go Facts: Seasons', 'Go Facts: Space', 'Go Facts: Transport', 'Godly Play', 'Going Places', 'Good Behaviour', 'Good Times Travel Agency', 'Gospel Perspectives', 'Graffix', 'Grantchester', 'Great Shakespeareans', 'Great Stage Directors', 'Greek Tales', 'Greek Texts', 'Green Guides', 'Gregory Sallust', 'Guardians of Time', 'Guides for the Perplexed', 'Guides to Contemporary Drama', 'Guides to the Apocrypha and Pseudepigrapha', 'Hacks for Minecrafters', 'Handbooks of Catholic Theology', 'Handwriting Today', 'Harriet Bean', 'Hart Monographs in Transnational and International Law', 'Hart Studies in Comparative Public Law', 'Hart Studies in Competition Law', 'Hart Studies in Constitutional Law', 'Hart Studies in European Criminal Law', 'Hart Studies in Private Law', 'Hart Studies in Security and Justice', 'Harvard Theological Studies', 'Haunting Emma', 'Have a Go English Tests', 'Have a Go Maths Tests', 'Have a Go Science Tests', 'Headlines', 'Health and Safety at Work Newsletter', 'Helm Country Avifaunas', 'Helm County Avifauna', 'Helm Field Guides', 'Helm Identification Guides', 'Helm Photographic Guides', 'Help Your Child to Succeed', 'Hero.com', 'Hey Fafa!', 'Historical Endings', 'Historicizing Modernism', 'History of American Thought', 'History of Art and Architecture', 'History of Crime, Deviance and Punishment', 'History of Technology', 'History of Witchcraft and Magic in Europe', 'History of the Ship', 'History: Bloomsbury Academic Collections', 'Holiday Activity and Sticker Books', 'Home', 'Home Cultures', 'Homework Today', 'Homeworms', 'Horizon Wars', 'Human Rights Law in Perspective', 'Improving Punctuation and Grammar', 'Ideas To Go: Better Behaviour', 'Ideas To Go: Creative Thinking', 'Ideas To Go: Science Experiments', 'Ideas To Go: Self-esteem', 'Ideas To Go: Thinking Skills', 'Ideas in Action', 'If Only . . .', 'Illuminating Modernity', 'Imagine Living Here', 'Impacts', 'Improving Comprehension', 'Improving Schools', 'Including Children With', 'Inclusion', 'Influential Video Game Designers', 'Inside Girl', 'Inside the Ancient World', 'Insiders', 'Inspirational Ideas', 'Instant Expert', 'Instant Lessons for Supply Teachers', 'Integrating Information and Communication Technology', 'Interiors Design, Architecture, Culture', 'International Critical Commentary', 'International Intellectual Property Law', 'International Perspectives on Europe', 'International Relations and the Great Powers', 'International Relations for the 21st Century', 'International Studies in Populism', 'International Studies in the Theory of Private Law', 'International Texts in Critical Media Aesthetics', 'Internet Projects', 'Interpretations', 'Interventions', 'Introduction to European Private Law', 'Introductions in Feminist Theology', 'Introductions to British Literature and Culture', 'Inventing the Nation', 'Irish Yearbook of International Law', 'Isobel Key', 'Issues in Contemporary Religion', 'Issues in Phenomenology and Hermeneutics', 'Issues in Science and Theology', 'Ius Commune Casebooks for the Common Law of Europe', 'JSOT/ASOR Monographs', 'Jets', 'Jewellery Handbooks', 'Jewish and Christian Text', 'John Albert Hall Lecture', 'Journal of Aesthetics and Phenomenology', 'Journal of Communication Design', 'Journal of Immigration, Asylum and Nationality Law', 'Journal of Pentecostal Theology Supplement', 'Journal of Professional Negligence', 'Journal of Textile Design Research and Practice', 'Julian Day', 'Jumbo Jets', 'Juridical Studies', 'Kant’s Sources in Translation', 'Kent Critical Law', 'Key Concepts', 'Key Concepts in Philosophy', 'Key Concepts in Religion', 'Key Debates in Educational Policy', 'Key Issues', 'Key Studies in Diplomacy', 'Key Terms', 'Key Texts in the Anthropology of Visual and Material Culture', 'Key Thinkers', 'Key Words', 'Keynote Studies from ''The Mariner''s Mirror''', 'Keystones', 'Kickstart Music', 'Kiki Strike', 'Knightley and Son', 'Knights'' Tales', 'Know the Game', 'Krefeld Historical Symposia', 'LSE Monographs on Social Anthropology', 'Landmark Cases', 'Late Victorian and Early Modernist Women Writers', 'Latin Texts', 'Law and Practical Reason', 'Lawyers'' Costs and Fees', 'Le Temps Mondial / World Time', 'Leapfrogs', 'Learning Activities for Early Years', 'Legal Theory Today', 'Leicester History of Religions', 'Leicester Museum Studies', 'Leisure, Consumption and Culture', 'Lesson Starters for Interactive Whiteboards', 'Let''s Talk About …', 'Lily Dale', 'Lincoln Studies in Religion and Society', 'Linguistics: Bloomsbury Academic Collections', 'Linkers: Art and Technology', 'Linkers: Geography', 'Linkers: History', 'Linkers: Science', 'Listening Hearts', 'Listening to Music', 'Literacy Now', 'Literary Genres', 'Literature and Culture Handbooks', 'Literature of Travel, Exploration and Empire', 'Literature, Culture, and Identity', 'Literatures, Cultures, Translation', 'Little Activity Books', 'Little Baby Books', 'Little Book of Big Ideas', 'Little Books', 'Little Books at Home', 'Little Books of Tips', 'Live Theory', 'Lives in Action', 'Loretta Lawson', 'Lost In', 'Lost World', 'Luke the Interpreter', 'Luxury', 'Magic Under Glass', 'Magnum Opus', 'Major Conservative and Libertarian Thinkers', 'Major Harry Maxim', 'Making Histories in Museums', 'Making the Most Of', 'Manuals Series', 'Maritime Monographs &amp; Reports', 'MasterClass', 'Material Religion', 'Materializing Culture', 'Maths', 'Maths Activity Books', 'Maths Today', 'Mediterranea', 'Meeting the Needs', 'Men-at-Arms', 'Mental Maths', 'Mental Maths Every Day', 'Mental Maths Tests', 'Mental Maths in Minutes', 'Mermaid S.O.S.', 'Methuen Drama Engage', 'Millie’s Misadventures', 'Mind Matters', 'Miss Malarkey', 'Model Shipwright', 'Modern Classics', 'Modern Plays', 'Modern Studies in European Law', 'Modern Studies in Property Law', 'Modern Theatre Guides', 'Modern Wars', 'Modernist Archives', 'Monkey and Robot', 'Music Express', 'Music Express Extra', 'Musical Steps', 'My Holiday To...', 'NDNA', 'NT in Context Commentaries', 'National Archives', 'Nationalism &amp; Internationalism', 'Naturecraft', 'Need', 'New Approaches to Anthropological Archaeology', 'New Approaches to International History', 'New Century Bible', 'New Century Theology', 'New Ceramics', 'New Childhoods', 'New Directions in European Writing', 'New Directions in German Studies', 'New Directions in Religion and Literature', 'New Directions in Social and Cultural History', 'New Directions in Terrorism Studies', 'New Germany in Context', 'New Horizons in Contemporary Writing', 'New Mermaids', 'New Modernisms', 'New Readings', 'New Research in Museum Studies', 'New Technologies / New Cultures', 'New Testament Guides', 'New Vanguard', 'Noisy Picture Books', 'Nonproliferation Studies', 'Number Journey', 'Numeracy 190', 'Numeracy Today', 'Nutshell Booklets', 'Oathbreaker', 'Object Lessons', 'Occupation in Europe', 'Old Testament Guides', 'Old Testament Studies', 'Omega', 'Open Book', 'Open Linguistics', 'Osgoode Readers', 'Osprey Games', 'Out of School', 'Outdoor Photography', 'Outstanding Christian Thinkers', 'Outstanding Teaching', 'Oñati International Series in Law and Society', 'Painting and Drawing', 'Paragon Issues in Philosophy', 'Parents'' Survival Guides', 'Parliamentary Democracy in Europe', 'Pass Your GCSE Maths', 'Pass Your KS3 Maths', 'Peony Pinker', 'Percussion Players', 'Performance Books', 'Performance and Science: Interdisciplinary Dialogues', 'Personalizing Learning', 'Perspectives on Leadership in Higher Education', 'Perspectives on the Holocaust', 'Philosophy and Theology', 'Philosophy, Aesthetics and Cultural Theory', 'Photographic Field Guides', 'Photographic Guides', 'Photography FAQs', 'Photography and Culture', 'Photography, History: History, Photography', 'Piano Magic', 'Pig Kahuna', 'Pirate Tales', 'Place to Talk', 'Play Anthologies', 'Playing the Texts', 'Plays and Playwrights', 'Plays for Young People', 'Pocket Guides', 'Pocket PAL', 'Political Arts', 'Political Theory and Contemporary Philosophy', 'Politics, Culture &amp; Society in the New Europe', 'Politics-Debates-Concepts', 'Poyser Monographs', 'Poyser Natural History', 'Practical Childcare', 'Practical Teaching Guides', 'Practise Time Tables', 'Practitioners'' Guides', 'Princess Academy', 'Princess Ponies', 'Printmaking Handbooks', 'Problems in Theology', 'Professional Development', 'Professional Media Practice', 'Psalms for Children Series', 'Publications of the Historian Liaison Group at the European Community Commission', 'Putnam''s History of Aircraft', 'Queering Theology', 'Quicksilver', 'Qumran Literature, Hebrew-English Edition', 'RADA Guides', 'RSPB', 'RYA', 'Radical Aesthetics-Radical Art', 'Raging Earth', 'Reaching the Standard', 'Reader''s Guides', 'Reading Augustine', 'Reading History', 'Reading Rainbow', 'Reading for Literacy', 'Readings: A New Biblical Commentary', 'Real Lives', 'Real World Research', 'Really Good Stuff', 'Recent Trends', 'Reconstructions in Early Modern History', 'Recorder Magic', 'Reed''s Almanac', 'Reeds Marine Engineering and Technology', 'Reeds Professional', 'Reflective Teaching', 'Religion Today', 'Religion and the University', 'Religion-Economy-Politics', 'Reputations', 'Required Reading Range', 'Research Methods in Linguistics', 'Resources for Teaching', 'River Cottage Handbook', 'Rockets', 'Roger Brook', 'Roman Tales', 'Romans', 'Romans Through History &amp; Culture', 'Rouleur', 'Roundabouts', 'Russian Texts', 'SAQ', 'SATs Practice', 'SEN in the Early Years', 'SOAS Studies in Modern and Contemporary Japan', 'Sailmate', 'Scarlet', 'Schizoanalytic Applications', 'Science Buzzwords', 'Science Ethics and Society', 'Science Explorers', 'Science Works', 'Scientific Studies of Religion: Inquiry and Explanation', 'Screen Adaptations', 'Screen Decades', 'Screen and Cinema', 'See For Yourself', 'Select Proceedings of the European Society of International Law', 'Sensory Formations', 'Sensory Studies', 'Sermons That Work', 'Setting Up Guides', 'Sex and Relationship Education', 'Shakespeare Now!', 'Shakespeare Tales', 'Shakespeare Today', 'Shakespeare and Language', 'Shakespeare and Theory', 'Shakespeare at Stratford', 'Shakespeare in the Theatre', 'Shakespeare: Bloomsbury Academic Collections', 'Shakespeare: The Critical Tradition', 'Sheffield Archaeological Monographs', 'Sheffield Environmental and Archaeological Research', 'Sheffield Excavation Reports', 'Sheffield Studies in Aegean Archaeology', 'Shipwright', 'Shire Library', 'Shiverton Hall', 'Simple Maths', 'Simple Science', 'Singing Express', 'Singing Languages', 'Singing Phonics', 'Singing Subjects', 'Six Week Workouts', 'So you want to be a...', 'Society for Old Testament Study Book List', 'Solve My Problems', 'Songbirds', 'Songbooks', 'Songsheets', 'Soundbytes', 'Sounds Fun!', 'Space School', 'Spacejackers', 'Spanish Texts', 'Speak Out', 'Special Educational Needs', 'Special Times', 'Spelling Today', 'Spelling for Literacy', 'Spiritual Directors International', 'Sport Commerce and Culture', 'Springboard Shakespeare', 'Springs of Wisdom', 'Stadium School', 'Stage Source Books', 'Stanislavski Studies', 'Star Fighters', 'Starting with…', 'State, Law and Society', 'Steps to Success', 'Sticker Activity Books', 'Sticker Storybooks', 'Stopwatch', 'Storecupboard Cookbooks', 'Stravaganza', 'Student Editions', 'Student Shakespeare Library', 'Studies in Antiquity &amp; Christianity', 'Studies in Christian Ethics', 'Studies in Early Medieval History', 'Studies in Ethnicity, Religion and Democracy', 'Studies in European Law and Integration', 'Studies in Fashion', 'Studies in Industrial Property and Copyright Law', 'Studies in International Law', 'Studies in International Trade Law', 'Studies in International and Comparative Criminal Law', 'Studies in Military History', 'Studies in Penal Theory and Penal Ethics', 'Studies in Private International Law', 'Studies in Psychical Research', 'Studies in Theology', 'Studies in Theology and Sexuality', 'Studies in the Early History of Britain', 'Studies in the History of Tax Law', 'Studies of the New Testament and Its World', 'Studies of the Oxford Institute of European and Comparative Law', 'Studies on the European Union', 'Studio Companion', 'Studying World Religions', 'Studying...', 'Subcultural Style', 'Sunny Sweet', 'Superhero School', 'Supporting Children', 'Supporting Development in the Early Years Foundation Stage', 'Supporting Literacy', 'Supporting Maths', 'Supporting Phonics and Spelling', 'Supporting Spelling', 'Supporting Writing Skills', 'Survey of London', 'Suspensions: Contemporary Middle Eastern and Islamicate Thought', 'Swedish Studies in European Law', 'T&amp;T Clark Approaches to Biblical Studies', 'T&amp;T Clark Cornerstones', 'T&amp;T Clark International Theological Commentary', 'T&amp;T Clark Studies in English Theology', 'T&amp;T Clark Studies in Fundamental Liturgy', 'T&amp;T Clark Studies in Systematic Theology', 'T&amp;T Clark Study Guides', 'Tales of Terror', 'Tales of the Frog Princess', 'Talking Images', 'Teaching Assistant''s Series', 'Technologies: Studies in Culture &amp; Theory', 'Teddybears', 'Telling the Time', 'Tempest', 'Textile', 'Textiles Handbooks', 'Textiles that Changed the World', 'Texts and Contexts', 'Textual Moments in the History of Political Thought', 'Textures: Philosophy, Literature, Culture', 'The ''What is?'' Research Methods Series', 'The A Circuit', 'The AVA Guides', 'The Academy', 'The Adlard Coles Classic Boat series', 'The Arden Shakespeare Third Series', 'The Avena Series', 'The Beckett Manuscript Project', 'The Bloomsbury Companions to Contemporary Filmmakers', 'The Bloomsbury History of Modern Russia Series', 'The Bone Season', 'The Calypso Chronicles', 'The Cartoon Chronicles of America', 'The Caves', 'The CineTech Guides to the Film Crafts', 'The Criminal Lawyer', 'The Cultural Histories Series', 'The Darkest Age', 'The Decades Series', 'The Design Journal', 'The Drake Chronicles', 'The Fairy-Tale Matchmaker', 'The Family in Antiquity', 'The Goose Pimple Bay Sagas', 'The Greats', 'The Harriet Tubman Series on the African Diaspora', 'The History of World Literatures on Film', 'The Joshua Files', 'The Journal of Modern Craft', 'The Justice Series - Putting Rights into Practice', 'The Key Concepts', 'The Legacy of the Great War', 'The Library of Episcopalian Classics', 'The Library of Hebrew Bible/Old Testament Studies', 'The Library of New Testament Studies', 'The Library of Second Temple Studies', 'The Lottie Lipton Adventures', 'The Lovegrove Legacy', 'The Makana Mysteries', 'The Malichea Quest', 'The Mudcrusts', 'The Mythic Misadventures', 'The New History of England', 'The Perfect Fire Trilogy', 'The Quirks', 'The Reception of British and Irish Authors in Europe', 'The Reception of Jesus in the First Three Centuries', 'The Rene Cassin Institute of Human Rights', 'The Robert and Arlene Kogod Library of Judaic Studies', 'The Seems', 'The Selfish Crocodile', 'The Senses and Society', 'The Sourcebooks Shakespeare', 'The Threes', 'The United Nations Series on Development', 'The United Nations and Global Change', 'The Village', 'The WISH List', 'The Wide-Awake Princess', 'The Wildlife Trusts', 'The Winner''s Trilogy', 'The Wombles', 'The deGranville Trilogy', 'Theatre Makers', 'Theatre Makers,Plays and Playwrights', 'Themes in Medieval History', 'Themes in Religious Studies', 'Theology for the 21st Century', 'Theology in Dialogue', 'Theory for Theatre Studies', 'Theory for a Global Age Series', 'Think Now', 'Thinkers', 'Thinking Cinema', 'Thinking Media', 'Threads', 'Throne of Glass', 'Through the Lens', 'Time and Mind', 'TimeRiders', 'Times Tables', 'Too! Books', 'Topics and Issues in National Cinema', 'Tough Jobs', 'Tough Times', 'Toybox Science', 'Trade Secrets of the Professionals', 'Trajectories: A Social-Science Commentary', 'Transformation, Development and Religionalization in Greater Asia', 'Transversals: New Directions in Philosophy', 'Treasures From the Spiritual Classics', 'Trolls', 'Trust Law International', 'Tudor Flashbacks', 'Tudor Tales', 'Tuesdays at the Castle', 'Twelve Dancing Princesses', 'Twilight Zone', 'Ukulele Magic', 'Ultimate Book Guides', 'Understanding Fashion', 'Understanding Philosophy, Understanding Modernism', 'Understanding the Bible and Its World', 'Unicorn Princesses', 'Urban Outlaws', 'VAT Digest', 'Victorian Flashbacks', 'Victorian Tales', 'Viking Tales', 'Violence, Desire, and the Sacred', 'Visual Dictionaries', 'Walter Benjamin Studies', 'War, Culture and Society', 'Warrior', 'Weapon', 'Weird Street', 'Wenner-Gren International Symposium Series', 'Wet Play Today', 'What Happened Here', 'What if?', 'What''s It Like to be a…?', 'Where to Watch Birds', 'Whitaker''s', 'White Wolves Non Fiction', 'White Wolves: Adventure Stories', 'White Wolves: Comparing Fiction Genres', 'White Wolves: Comparing Work', 'White Wolves: Fairy Tales', 'White Wolves: Familiar Settings ', 'White Wolves: Folk Tales', 'White Wolves: Imagined Worlds', 'White Wolves: Issues', 'White Wolves: Myths and Legends', 'White Wolves: Playscripts', 'White Wolves: Shakespeare Retellings', 'White Wolves: Stories from Different Cultures', 'White Wolves: Stories from World Religions', 'White Wolves: Stories with Historical Settings', 'White Wolves: Traditional Stories', 'White Wolves: World Folk Tales', 'Who''s Who', 'Who''s Who in…?', 'Why Philosophy Matters', 'Wild Cards', 'Wild Things!', 'Wild World', 'Wired', 'Wired Connect', 'Wired Up', 'Wired Up Connect', 'Wisden Sports Writing', 'Women Make Cinema', 'Women Who Broke the Rules', 'Women in Context: Women''s Writing', 'Women, Power and Politics', 'Wooden Books', 'Working in the Theatre Seminars', 'World Classics', 'World Englishes', 'World Sports Guide', 'World War I Tales', 'World War I Tales, World War II Tales', 'World War II Flashbacks', 'World War II Stories', 'World War II Tales', 'Writers Lives', 'Writers'' and Artists''', 'Writers'' and Artists'' Companions', 'Writing Handbooks', 'Writing History', 'Writing for Literacy', 'Writing on Writing', 'Yachting Monthly')">The series name does not match one of the known Bloomsbury series. Check the spelling and punctuation. If you have a new series which needs to be added to the list, please contact Bloomsbury immediately.</assert>
</rule>
<!-- Others -->
<rule context="db:biblioset[@role='series']/db:title | db:biblioset[@role='series']/db:volumenum" id="series-att-context">
<assert test="@role='series'" id="role-series">Element <name/> must have @role=series. &check_ancestor;</assert>
</rule>
<rule context="db:biblioset[@role='series']/db:bibliomisc" id="series-misc-context">
<assert test="@role='previousTitle'" id="prev-title">Element <name/> must have @role=previousTitle. &check_ancestor;</assert>
<report test="@role='previousTitle'" role="info" id="series-prev-title">Series has a previous title (<value-of select=".[@role='previousTitle']"/>), &check_ancestor;</report>
</rule>
</pattern>

<pattern id="geographers">
<title>Specific tests for the Geographers series</title>
<rule context="db:biblioset[@role='series']/db:title[matches(.,'^Geographers')]" id="geog-context">
<assert test="matches(., 'Geographers: Biobibliographical Studies')" id="geog-title">If a series title starts with 'Geographers' it must be 'Geographers: Biobibliographical Studies' &check_id;</assert>
</rule>
<rule context="db:book/db:info/db:title[matches(.,'^Geographers') and contains(., 'Biobibliographical')]" id="geog-context-biobliographical">
<assert test="../db:biblioset[@role='series']/db:title[matches(.,'^Geographers: Biobibliographical Studies$')]" id="geog-title2">Books with 'Geographers' and 'Biobibliographical' in the title must have the correct series, &check_id;</assert>
</rule>
</pattern>
<pattern id="geographers-2">
<title>Additional specific tests for the Geographers series</title>
<let name="volnum" value="/db:book/db:info/db:volumenum"/>
<rule context="db:biblioset[@role='series']/db:title[matches(.,'^Geographers: Biobibliographical Studies$')]" id="geog-context2">
<assert test="../db:volumenum" id="geog-volnum">Books in the 'Geographers' series must have a volumenum in the series data &check_id;</assert>
<assert test="ancestor::db:book/descendant::db:olink" id="geog-volnum2">Books in the 'Geographers' series must have cross references to other books in the series using olink</assert>
</rule>
<rule context="db:biblioset[@role='series'][db:title[matches(.,'^Geographers: Biobibliographical Studies$')]]/db:volumenum" id="geog-context3">
<assert test=". = $volnum" id="geog-volnum3">The volumenum in the series data must match that in book/info &check_id;</assert>
</rule></pattern>

<pattern id="language">
<title>A book must have its main language declared, and where @xml:lang is used it must be a valid value</title>
<!-- ISO 639 two letter codes + Ancient Greek (grc) -->
<let name="iso639" value="'ab', 'aa', 'af', 'ak', 'sq', 'am', 'ar', 'an', 'hy', 'as', 'av', 'ae', 'ay', 'az', 'bm', 'ba', 'eu', 'be', 'bn', 'bh', 'bi', 'bs', 'br', 'bg', 'my', 'ca', 'ch', 'ce', 'ny', 'zh', 'cv', 'kw', 'co', 'cr', 'hr', 'cs', 'da', 'dv', 'nl', 'dz', 'en', 'eo', 'et', 'ee', 'fo', 'fj', 'fi', 'fr', 'ff', 'gl', 'ka', 'de', 'el', 'gn', 'gu', 'ht', 'ha', 'he', 'hz', 'hi', 'ho', 'hu', 'ia', 'id', 'ie', 'ga', 'ig', 'ik', 'io', 'is', 'it', 'iu', 'ja', 'jv', 'kl', 'kn', 'kr', 'ks', 'kk', 'km', 'ki', 'rw', 'ky', 'kv', 'kg', 'ko', 'ku', 'kj', 'la', 'lb', 'lg', 'li', 'ln', 'lo', 'lt', 'lu', 'lv', 'gv', 'mk', 'mg', 'ms', 'ml', 'mt', 'mi', 'mr', 'mh', 'mn', 'na', 'nv', 'nb', 'nd', 'ne', 'ng', 'nn', 'no', 'ii', 'nr', 'oc', 'oj', 'cu', 'om', 'or', 'os', 'pa', 'pi', 'fa', 'pl', 'ps', 'pt', 'qu', 'rm', 'rn', 'ro', 'ru', 'sa', 'sc', 'sd', 'se', 'sm', 'sg', 'sr', 'gd', 'sn', 'si', 'sk', 'sl', 'so', 'st', 'az', 'es', 'su', 'sw', 'ss', 'sv', 'ta', 'te', 'tg', 'th', 'ti', 'bo', 'tk', 'tl', 'tn', 'to', 'tr', 'ts', 'tt', 'tw', 'ty', 'ug', 'uk', 'ur', 'uz', 've', 'vi', 'vo', 'wa', 'cy', 'wo', 'fy', 'xh', 'yi', 'yo', 'za', 'zu', 'grc'"/>
<rule context="db:book" id="book-lang-context">
<assert test="@xml:lang" id="lang-attribute">The <name/> must include an xml:lang attribute, &check_id;</assert>
</rule>
<rule context="*/@xml:lang" id="lang-context">
<assert test=". = $iso639" id="lang-attribute-value">The <name/> @xml:lang must be a valid value. Currently = <value-of select="."/>, &check_id;</assert>
<report test="(matches(., '^he$') or matches(., '^ar$')) and not(parent::element()[@dir='rtl'])" id="rtl-scripts">Language (@xml:lang) = <value-of select="."/> but @dir is not rtl, &check_ancestor;</report>
<report test="not(matches(., '^he$') or matches(., '^ar$')) and parent::element()[@dir='rtl']" id="non-rtl-scripts">Language (@xml:lang) = <value-of select="."/> but @dir should not be rtl, &check_ancestor;</report>
<!-- Report to info if non-English text included at all -->
<report test=". != 'en'" role="info" id="non-english-text">The <name path="parent::element()"/> @xml:lang is not English. Value = <value-of select="."/>, &check_ancestor;</report>
</rule>
<rule context="db:foreignphrase" id="foreign-context">
&precedingPageNoVariable;
<assert test="@xml:lang" id="foreignphrase-lang">A foreignphrase element must have an @xml:lang attribute, &check_ancestor; &pageNoAndChunkPDF;</assert>
</rule>
</pattern>

<pattern id="specific-language-tests">
<title>Specific language tests</title>
<rule context="text()[matches(., '[א-ת]+')]" id="hebrew-context">
&precedingPageNoVariable;
<assert test="parent::db:foreignphrase" id="hebrew">Hebrew text must be in a foreignphrase, &check_ancestor; &pageNoAndChunkPDF;</assert>
</rule>
<rule context="text()[matches(., '[ء-ي]+')]" id="arabic-context">
&precedingPageNoVariable;
<assert test="parent::db:foreignphrase" id="arabic">Arabic text must be in a foreignphrase, &check_ancestor; &pageNoAndChunkPDF;</assert>
</rule>
<rule context="db:foreignphrase[matches(., '[א-ת]+')]" id="hebrew-att-context">
&precedingPageNoVariable;
<assert test="@xml:lang='he'" id="foreignphrase-he">Hebrew text in a foreignphrase element must have an @xml:lang='he', &check_ancestor; &pageNoAndChunkPDF;</assert>
</rule>
<rule context="db:foreignphrase[matches(., '[ء-ي]+')]" id="arabic-att-context">
&precedingPageNoVariable;
<assert test="@xml:lang='ar'" id="foreignphrase-ar">Arabic text in a foreignphrase element must have an @xml:lang='ar', &check_ancestor; &pageNoAndChunkPDF;</assert>
</rule>
</pattern>


<pattern id="author-editor">
<title>Should there be an editor?</title>
<rule context="db:book[not(db:info/descendant::db:editor)]" id="ed-book-context">
<report test="count(descendant::db:chapter[db:info/descendant::db:author]) gt 1" role="warning" id="possible-edited-book">There is more than one authored chapter, but the book/info does not contain an editor, OK? &check_id;</report>
</rule>
</pattern>

<!-- Creative Commons -->
<pattern id="creative-commons-test">
<title>Detect possible Open Access titles</title>
<rule context="db:legalnotice[contains(.,'Creative Commons')]" id="cc-context">
<assert test="@role='CC'" id="legalnotice-cc">Legal notice contains text "Creative Commons, but does not have @role=CC &named_element_with_id;</assert>
</rule>
</pattern>
<pattern id="creative-commons2etc">
<title>Other tests around Open Access titles and CIP data</title>
<rule context="db:legalnotice" id="legal-context">
<report test="@role='CC' or @role='Open'" role="info" id="open-access">Book "<value-of select="ancestor::db:info/db:title"/>" is Open Access (type = <value-of select="@role"/>)</report>
<report test="@role='CC' and not(contains(., 'Creative Commons'))" id="not-cc">Book has @role=CC legalnotice but text does not contain "Creative Commons". Is it really a Creative Commons title?, &check_ancestor;</report>
<report test="@role='Open' and not(contains(., 'free to share'))" id="not-open">Book has @role=Open legalnotice but text does not contain "free to share". Is it really an Open Access title?, &check_ancestor;</report>
<report test="contains(., 'British Library') and not(@role='CIP')" id="bl-cip">The legalnotice contains "British Library" but does not have @role=CIP, &check_ancestor;</report>
<report test="contains(., 'Library of Congress') and not(@role='CIP')" id="loc-cip">The legalnotice contains "Library of Congress" but does not have @role=CIP, &check_ancestor;</report>
</rule>
</pattern>

<pattern id="cip">
<rule context="db:legalnotice[@role='CIP']" id="cip-context">
<report test="db:para[contains(., 'Library of Congress')]/following-sibling::db:para[contains(., 'British Library')] or db:para[contains(., 'Library of Congress')]/preceding-sibling::db:para[contains(., 'British Library')]" id="loc-cip2">The legalnotice contains "Library of Congress" and "British Library"; there needs to be a separate CIP legalnotice for each, &check_ancestor;</report>
</rule>
</pattern>
<!-- ISBNs -->
<pattern id="isbn-format-length">
<title>ISBN format and length</title>
		<rule context='db:biblioid[@class="isbn" and @role]' id="isbn-context-a">
			<assert role='warning' test="string-length(translate(., ' -', '')) = 13" id="isbn-length">ISBN should normally be 13 digits long. &check_ancestor;</assert>
			<assert role='error' test="contains(., ' ') or contains(., '-')" id="isbn-format">ISBNs must contain space or hyphen characters in its correct format. &check_ancestor;</assert>
		</rule>
</pattern>	
<pattern id="isbn-type-duplicates">
<title>Ensure there is only one of any type of ISBN</title>
<rule context="db:biblioid[@class='isbn']" id="isbn-context-2">
			<report test="string(@role) = string(following-sibling::db:biblioid[1]/@role)" id="isbn-types">Multiple ISBNs with @role = <value-of select="@role"/> &check_ancestor;</report>
</rule>
</pattern>	

<!-- Digital Object Identifiers (DOIs) -->
	<pattern id="duplicated_doi"> 
        <title>DOIs must be unique within a book</title>
		<rule context="db:biblioid[@class='doi']" id="doi-context"> 
			<assert test="count(key('doi', .)) = 1" id="duplicate-doi">Duplicated doi  - "<value-of select='.'/>", &check_ancestor;</assert>
		</rule> 
	</pattern> 

	<pattern id='book-DOI'>
<title>Digital Object Identifiers</title>
		<rule context="db:book/db:info[not(db:biblioid[@otherclass='DOInotRequired'] = '1')]" id="book-doi-context">
			<assert test="db:biblioid[@class='doi']" id="doi-present">Book must have a DOI &check_ancestor;</assert>
			<report test="db:biblioset[@role='isbns']/db:biblioid[@class='doi']" id="info-doi">Book DOI must be a direct child of info &check_ancestor;</report>
		</rule>
	</pattern>
        
        <pattern id="book-doi2">
                <title>DOIs 2</title>
                <!-- Exception deals with historic DOIs for Berg Encyclopedia of World Dress and Fashion -->
                <rule context='db:book/db:info[db:biblioid[@class="doi"][not(starts-with(., "10.2752/BEWDF"))]]' id="book-doi-context2">
                        <assert test="string(translate(db:biblioset[@role='isbns']/db:biblioid[@role='xml'], ' -', '')) = substring-after(db:biblioid[@class='doi'],'10.5040/')" id="book-doi-isbn">Book DOI must use XML ISBN as its root &check_ancestor;</assert>
                </rule>
        </pattern>

    <pattern id="global-DOIs">
<title>Global DOI integrity tests</title>
		<rule context='db:biblioid[@class="doi"]' id="doi-context-2">
			<assert test="substring-before(., '/') = ('10.5040', '10.2752')" id="doi-format">DOIs must have the prefix 10.5040 or (for old Berg content) 10.2752 &check_ancestor;</assert>
		</rule>
    </pattern>

<pattern id="global-DOIs2">
<title>Another global DOI test</title>
        <!-- Exception deals with historic DOIs for Berg Encyclopedia of World Dress and Fashion -->
        <rule context='db:biblioid[@class="doi"][ancestor::db:book or ancestor::db:set][not(starts-with(., "10.2752/BEWDF"))]' id="doi-context-3">
			<assert test="if (ancestor::db:book) then string(translate(ancestor::db:book/db:info/db:biblioset[@role='isbns']/db:biblioid[@role='xml'], ' -', '')) = substring(.,9,13) else string(translate(ancestor::db:set/db:info/db:biblioset[@role='isbns']/db:biblioid[@role='xml'], ' -', '')) = substring(.,9,13)" id="doi-isbn">DOIs must use XML ISBN as its root &check_ancestor;</assert>
</rule>
</pattern>

<pattern id="keywords">
<title>Keywords and keywordsets</title>
<rule id="keywordset-context" context="db:article/db:info[starts-with(substring-after(db:biblioid[@class='doi'], '10.5040/9781474260428-'), 'FPA')]/db:keywordset">
<!-- For FPA articles, we don't want BergGlossary as a @role value -->
<report test="@role='BergGlossary'" id="fpa-glossary">A keywordset with @role=BergGlossary is not required in an FPA article, &check_id;</report>
<!-- For FPA articles, the BergKeywords group should be fashionKeywords -->
<report test="@role='BergKeywords'" id="fpa-keywords">A keywordset with @role=BergKeywords in an FPA article should be @role=fashionKeywords, &check_id;</report>
</rule>
</pattern>

<!-- Global checks -->
<pattern id="general-tests">
<title>A mixed bag of tests for suspicious-looking patterns that probably need marking up, or which may have too much markup</title>
<rule context="db:bibliomisc[@role='contributorStatement']" id="contrib-st-context">
<assert test="parent::db:info" id="contrib-statement-location">A contributor statement is present but is not within a chunk "info", &check_ancestor;</assert>
</rule>
<rule context="text()[matches(., '10\.\d\d\d\d/')][not(parent::db:biblioid[@class='doi'])]" id="poss-doi-context">
&precedingPageNoVariable;
<assert role="warning" test="ancestor::db:link" id="unlinked-doi">Text string of the form "10.dddd/" looks like a DOI but is not in a "link", &check_id; &pageNoAndChunkPDF;</assert>
</rule>
<rule context="db:title[not(ancestor::db:bibliomixed)] | db:subtitle[not(ancestor::db:bibliomixed)]" id="bib-title-context">
<report role="warning" test="string-length(.) = string-length(concat(db:emphasis[1],db:emphasis[2],db:emphasis[3],db:emphasis[4]))" id="title-not-all-emphasis">Content of title is entirely in "emphasis" which is probably unnecessary, &check_id;</report>
</rule>
<rule context="*" id="xreflabel-context">
<report test="@xreflabel" id="xreflabel-not-required"><name/> must not have @xreflabel. Links use link and do not autogenerate their link text, &check_id;</report>
</rule>
</pattern>

<pattern id="general-tests-2">
<title>More general tests</title>
<rule context="db:info/db:title | db:info/db:subtitle" id="title-content-context">
&precedingPageNoVariable;
<report test="(contains(., 'Dedication') or contains(., 'dedication')) and not(@outputformat='e-Only')" role="warning" id="dedication-in-title">Title of <name path="parent::element()/parent::element()"/> element contains the word "Dedication"; does it appear in print? if not, title should probably have @outputformat=e-Only, &check_id; &pageNoAndChunkPDF;</report>
<report test="(contains(., 'Epigraph') or contains(., 'epigraph')) and not(@outputformat='e-Only')" role="warning" id="epigraph-in-title">Title of <name path="parent::element()/parent::element()"/> element contains the word "Epigraph"; does it appear in print? if not, title should probably have @outputformat=e-Only, &check_id; &pageNoAndChunkPDF;</report>
<report test="db:author or db:editor or db:othercredit" id="contributor-in-title">An author, editor or othercredit is not permitted in a <name/> element, &check_id;</report>
</rule>
</pattern>

<!-- Add tests for <cover> -->

<pattern id="case-regularisation-check">
<title>Some key elements must not have their contents in all caps other than in very specific circumstances, and so we also need to have some case regularisation tests as well</title>
<rule context="db:info/db:title[not(ancestor::db:formalpara)] | db:info/db:title/db:subtitle | db:info//db:firstname[not(@role='initials')] | db:info//db:othername[not(@role='middle-initials')] | db:info//db:surname | db:info//db:orgname | db:info//db:bibliomisc[@role='imprint']" id="case-context">
&precedingPageNoVariable;
<!-- If string length of title is a single character then upper case only is OK, otherwise it probably isn't unless it is an acronym -->
<report role="warning" test="if (string-length(.) = 1) then 0 else (string-length(translate(normalize-space(),'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890- :;?!\,.','')) = 0)" id="case-regularisation">info//<name/> should not normally contain only upper case letters  and/or numbers (<value-of select="."/>), unless it is an acronym or a heading comprising only numbers, so may need a specific @role or to be regularised according to editorial rules &check_id; &pageNoAndChunkPDF;</report>
<!-- This list may need modifying, depending on capitalisation rules -->
<!--<report role="warning" test="descendant::node()[not(ancestor-or-self::db:footnote)][contains(., ' A ')]">Is capitalisation correct? Includes "A", which is probably not right &check_id;</report>
<report role="warning" test="descendant::node()[not(ancestor-or-self::db:footnote)][contains(., ' The ')]">Is capitalisation correct? Includes "The", which is probably not right &check_id;</report>
<report role="warning" test="descendant::node()[not(ancestor-or-self::db:footnote)][contains(., ' An ')]">Is capitalisation correct? Includes "An", which is probably not right &check_id;</report>
<report role="warning" test="descendant::node()[not(ancestor-or-self::db:footnote)][contains(., ' And ')]">Is capitalisation correct? Includes "And", which is probably not right &check_id;</report>
<report role="warning" test="descendant::node()[not(ancestor-or-self::db:footnote)][contains(., ' Or ')]">Is capitalisation correct? Includes "Or", which is probably not right &check_id;</report>
<report role="warning" test="descendant::node()[not(ancestor-or-self::db:footnote)][contains(., ' By ')]">Is capitalisation correct? Includes "By", which is probably not right &check_id;</report>
<report role="warning" test="descendant::node()[not(ancestor-or-self::db:footnote)][contains(., ' But ')]">Is capitalisation correct? Includes "But", which is probably not right &check_id;</report>
<report role="warning" test="descendant::node()[not(ancestor-or-self::db:footnote)][contains(., ' Yet ')]">Is capitalisation correct? Includes "Yet", which is probably not right &check_id;</report>
<report role="warning" test="descendant::node()[not(ancestor-or-self::db:footnote)][contains(., ' Nor ')]">Is capitalisation correct? Includes "Nor", which is probably not right &check_id;</report>
<report role="warning" test="descendant::node()[not(ancestor-or-self::db:footnote)][contains(., ' So ')]">Is capitalisation correct? Includes "So", which is probably not right &check_id;</report>
<report role="warning" test="descendant::node()[not(ancestor-or-self::db:footnote)][contains(., ' To ')]">Is capitalisation correct? Includes "To", which is probably not right &check_id;</report>
<report role="warning" test="descendant::node()[not(ancestor-or-self::db:footnote)][contains(., ' As ')]">Is capitalisation correct? Includes "As", which is probably not right &check_id;</report>
<report role="warning" test="descendant::node()[not(ancestor-or-self::db:footnote)][contains(., ' Of ')]">Is capitalisation correct? Includes "Of", which is probably not right &check_id;</report>
<report role="warning" test="descendant::node()[not(ancestor-or-self::db:footnote)][contains(., ' In ')]">Is capitalisation correct? Includes "In", which is probably not right &check_id;</report>
<report role="warning" test="descendant::node()[not(ancestor-or-self::db:footnote)][contains(., ' On ')]">Is capitalisation correct? Includes "On", which is probably not right &check_id;</report>
--></rule>
</pattern>

<!-- Not sure this is working, and also need to check that pdfOnly doesn't contain anything else -->
<!--   + toc-->
    <pattern id="pdf-only-remark">
		<rule context='db:book[@role="pdfOnly"]//db:chapter | db:book[@role="pdfOnly"]//db:preface |  db:book[@role="pdfOnly"]//db:acknowledgements | db:book[@role="pdfOnly"]//db:glossary | db:book[@role="pdfOnly"]//db:index | db:book[@role="pdfOnly"]//db:bibliography | db:book[@role="pdfOnly"]//db:appendix | db:book[@role="pdfOnly"]//db:part[db:partintro] | db:book[@role="pdfOnly"]//db:toc' id="pdf-only-context">
			<assert test="db:remark" id="remark-required">Chunk blocks must contain the standard empty "remark" in pdf-only XML &check_ancestor;</assert>
            <assert test="db:remark[@condition='hidden']" id="remark-hidden">remark elements in pdfOnly books must have @condition=hidden &check_ancestor;</assert>
            <report test="*[local-name() = $all-blocks]" id="unpermitted-content">pdfOnly books should not have content other than remark &check_ancestor;</report>
		</rule>
    </pattern>

<pattern id="remarks">
<title>Remarks</title>
<rule context="db:remark" id="remark-context">
<assert test="parent::db:preface or parent::db:chapter or parent::db:acknowledgements or parent::db:part or parent::db:toc or parent::db:glossary or parent::db:index or parent::db:appendix or parent::db:bibliography or parent::db:dedication" id="remark-error">A remark element is not permitted within a <name path="parent::node()"/>, &check_ancestor;</assert>
</rule>
</pattern>

<pattern id="chunk-contents">
<title>A group of tests relating to all content chunks</title>
<rule context="&chunk_blocks;" id="all-chunks-context">
&precedingPageNoVariable;
<report test="db:info/db:mediaobject/db:imageobject[@role='suppressPDF']" id="pdf-suppress-incorrect">Chunks with content must not have a suppress PDF flag on the imageobject &named_element_with_id;</report>
<report role="warning" test="db:blockquote[preceding-sibling::element()[1][self::db:info] and not(following-sibling::element())]" id="only-blockquote-content">Chunk text only contains a blockquote, which is almost certainly wrong, &check_id; &pageNoAndChunkPDF;</report>
<report test="db:info/db:bibliomisc[@role='contributorStatement']" role="info" id="contrib-statement-present">A contributor statement is present (<value-of select="db:info/db:bibliomisc[@role='contributorStatement']"/>), &check_id;</report>
<report test="ancestor::db:book[@role='fullText'] and db:info/db:abstract[@role='extract']" id="full-text-extract">Full text XML books must not contain an extract. Any abstract in them must be authorAbstract, &check_id;</report>
<report test="db:info//db:editor" role="warning" id="chunk-editor-present">Content chunk has an editor. Is that correct? &check_id; &pageNoAndChunkPDF;</report>
<report test="contains(translate(db:info/db:title, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'acknowledgements') and not(self::db:acknowledgements)" id="acknowledgements-present" role="warning">Chunk title contains "acknowledgements", but is not in an acknowledgements element, &check_id; &pageNoAndChunkPDF;</report>
<report test="db:info/db:date" id="date-in-info" role="warning">There is a date in a chunk info, which is not usual, &check_id; &pageNoAndChunkPDF;</report>
<report test="db:info/following-sibling::element()[1][self::db:poetry or self::db:drama or self::db:blockquote]" id="possible-epigraph" role="warning">First element in chunk after info is <name path="db:info/following-sibling::element()[1]"/>. Should it be an epigraph? &check_id; &pageNoAndChunkPDF;</report>
        <assert test="if (self::db:toc or self::db:preface[@role='prelims'] or self::db:index) then 1 else (db:info/following-sibling::element())" id="content-required">A chunk element must have some content, &check_id;</assert>
        <report test="db:info/db:title[ends-with(., ':')]" id="chunk-colon">A chunk title ends with a colon, which is wrong. Please remove it, &check_id;</report>
</rule>
<rule context="db:article" id="article-context">
&precedingPageNoVariable;
<report role="warning" test="db:blockquote[preceding-sibling::element()[1][self::db:info] and not(following-sibling::element())]" id="only-blockquote-content-article">Article text only contains a blockquote, which is almost certainly wrong, &check_id; &pageNoAndChunkPDF;</report>
<report test="db:info/db:bibliomisc[@role='contributorStatement']" role="info" id="contrib-statement-present-article">A contributor statement is present (<value-of select="db:info/db:bibliomisc[@role='contributorStatement']"/>), &check_id;</report>
<report test="ancestor::db:book[@role='fullText'] and db:info/db:abstract[@role='extract']" id="full-text-extract-article">Full text XML books must not contain an extract. Any abstract in them must be authorAbstract, &check_id;</report>
<report test="db:info//db:editor" role="warning" id="article-editor-present">Article has an editor. Is that correct? &check_id; &pageNoAndChunkPDF;</report>
<report test="db:info/db:date" id="date-in-article-info" role="warning">There is a date in an article info, which is not usual, &check_id; &pageNoAndChunkPDF;</report>
<report test="db:info/following-sibling::element()[1][self::db:poetry or self::db:drama or self::db:blockquote]" id="possible-epigraph-article" role="warning">First element in chunk after info is <name path="db:info/following-sibling::element()[1]"/>. Should it be an epigraph? &check_id; &pageNoAndChunkPDF;</report>
</rule>
<rule context="db:epigraph" id="epigraph-context">
&precedingPageNoVariable;
<report test="preceding-sibling::db:para" role="warning" id="para-before-epigraph">An epigraph usually sits at the beginning of a chunk or section; this has preceding paragraphs, probably should be a blockquote, &check_id; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

<pattern id="content-chunks-2">
<title>Rules for content chunks where there is a print edition</title>
<rule context="&chunk_blocks_print;" id="chunk-print-context">
&precedingPageNoVariable;
<assert test="db:info/db:pagenums" id="pagenums-present">Chunk blocks must contain a page range. See &named_element_with_id; &pageNoAndChunkPDF;</assert>
<assert test="count(db:info/db:pagenums) = 1" id="pagenums-count">Chunk blocks must contain only one page range. See &named_element_with_id; &pageNoAndChunkPDF;</assert>
<assert test="db:info/db:mediaobject/db:imageobject/db:imagedata[@format='application/pdf']" id="chunk-pdf-present">Chunk blocks must contain PDF fileref, see &named_element_with_id;</assert>
</rule>
</pattern>

<pattern id="abstracts-etc">
<title>Content that should be abstracts or not included</title>
<rule context="db:title" id="abstract-title-context">
&precedingPageNoVariable;
<report test="matches(., '^Abstract$')" role="warning" id="possible-abstract"><name path="parent::db:info/parent::element()"/>//title = "Abstract". Should this be an title-less "abstract" element in info? &check_id; &pageNoAndChunkPDF;</report>
<report test="matches(., '^Chapter Outline$')" role="warning" id="remove-chapter-outline"><name path="parent::db:info/parent::element()"/>//title = "Chapter Outline". If this is only a table of contents it should not be in the XML at all. &check_id; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

<pattern id="e-only">
<title>Tests for e-Only outputformat situations</title>
<rule context="db:book[@outputformat]" id="book-format-context">
<assert test="@outputformat='e-Only'" id="outputformat-e-only">The only permissible value of @outputformat on a book is 'e-Only', &check_id;</assert>
</rule>
<rule context="db:info[ancestor::db:book[@outputformat='e-Only']]" id="eonly-context">
<report test="db:pagenums" id="pagenums-e-only">There must not be pagenums in an e-Only book, &check_ancestor;</report>
</rule>
</pattern>

<pattern id="toc-issues">
<title>Issues to note about Tables of Contents</title>
<rule context="db:toc" id="toc-context">
&precedingPageNoVariable;
<assert test="parent::db:part[@role='front']" id="toc-warning">"toc" element is not within a front container. If book structure requires a toc in this location, please contact the publisher &pageNoAndChunkPDF;</assert>
</rule>
<rule context="db:toc/db:info/db:title" id="toc-title-context">
&precedingPageNoVariable;
<report test="(contains(., 'Cases') or contains(., 'Statutes') or contains(., 'Legislation') or contains(., 'Statutory') or contains(., 'Law Commission'))" id="legal-toc"><name/> (<value-of select="."/>) looks like a table of cases or statutes, so must be in a preface element, &check_id; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

<pattern id="legal">
<title>Legal contents</title>
<rule context="db:preface[descendant::db:variablelist]/db:info/db:title[(contains(., 'Cases') or contains(., 'Statutes') or contains(., 'Legislation') or contains(., 'Statutory') or contains(., 'Law Commission'))]" id="legal-contents-context2">
<assert test="ancestor::db:preface[@role='legalContents']" id="legal-contents">A preface containing a table of cases or statutes etc must have @ role=legalContents, &check_id;</assert>
</rule>
<rule context="db:preface[@role='legalContents'][not(ancestor::db:book[@role='pdfOnly'])]" id="legal-contents-context">
&precedingPageNoVariable;
<assert test="descendant::db:variablelist" id="legal-preface">A <name/> with @role=legalContents must have its content within a variablelist, &check_id; &pageNoAndChunkPDF;</assert>
</rule>
<rule context="db:preface[@role='legalContents']/db:variablelist//db:para" id="legal-links-context">
&precedingPageNoVariable;
<assert test="db:link" id="legal-contents-links" role="warning">A <name/> in a  preface[@role=legalContents] should usually contain one or more links, &check_id; &pageNoAndChunkPDF;</assert>
</rule>
</pattern>

<pattern id="poetry-drama">
<title>Poetry and drama tests</title>
<rule context="db:poetry | db:drama | db:dialogue" id="drama-poetry-context">
&precedingPageNoVariable;
<report test="self::*" id="poetry-drama-present" role="information">A <name/> element is present with parent <value-of select="parent::element()/name()"/>, &check_id; &pageNoAndChunkPDF;</report>
<report test="not(ancestor::db:blockquote) and not(ancestor::db:epigraph)" role="warning" id="drama-poetry-parent">A <name/> element should usually be in a blockquote, &check_id; &pageNoAndChunkPDF;</report>
</rule>
<!--<rule context="db:dialogue">
<assert test="parent::db:drama" id="dialogue-in-drama">A dialogue must be within a drama, &check_id;</assert>
</rule>-->
<rule context="db:line[@role='partInitial']" id="initial-context">
&precedingPageNoVariable;
<assert id="part-initial" test="following::db:line[@role='partMedial'][1] or following::db:line[@role='partFinal'][1]">A line[@role=partInitial] must be followed by a partMedial or partFinal, &check_id; &pageNoAndChunkPDF;</assert>
</rule>
<rule context="db:line[@role='partFinal']" id="final-context">
&precedingPageNoVariable;
<assert id="part-final" test="preceding::db:line[@role='partMedial'][1] or preceding::db:line[@role='partInitial'][1]">A line[@role=partFinal] must be preceded by a partMedial or partInitial, &check_id;&pageNoAndChunkPDF;</assert>
</rule>
<rule context="db:line[@role='partMedial']" id="medial-context">
&precedingPageNoVariable;
<assert id="part-medial" test="(following::db:line[@role='partFinal'][1] or following::db:line[@role='partMedial'][1]) and (preceding::db:line[@role='partInitial'][1] or preceding::db:line[@role='partMedial'][1])">A line[@role=partMedial] must have a partInitial before and a partFinal after, &check_id; &pageNoAndChunkPDF;</assert>
</rule>
<rule context="db:blockquote | db:epigraph" id="poss-quote-context">
&precedingPageNoVariable;
<report id="possible-poem" role="warning" test="count(db:para[string-length(.) lt 50]) > 3"><name/> contains more than three short paragraphs; should it be a poem with lines? or a list? &check_id; &pageNoAndChunkPDF;</report>
<report test="db:para[last()][@role='right']" role="warning" id="possible-attribution">The last para in the '<name/>' element has @role=right. Should it be an attribution element instead? &check_id; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

<pattern id="poetry-drama-2">
<title>Additional tests for poetry and drama etc</title>
<rule context="db:line/text()" id="line-attribution-context">
&precedingPageNoVariable;
<report test="matches(., '\([0-z\.,-]+\)$')" id="line-attribution" role="warning">Bracketed content at the end of a line element. Should it be an attribution in a parent blockquote or epigraph? &check_ancestor; &pageNoAndChunkPDF;</report>
<report test="matches(.[not(ancestor::db:footnote)], '^\(?[0-9]+') or matches(.[not(ancestor::db:footnote)], '[0-9]+\)?$')" id="poss-line-number" role="warning"><name path="parent::element()"/> starts or ends with a number. Should it be a line number using footnote[@role=margin1 | margin2]? &check_ancestor; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

<pattern id="titles-with-numbers">
<title>Titles in chunks, sections, figures etc that start with a number should almost certainly have that value in @label</title>
<rule context="db:info[not(parent::db:formalpara)]" id="poss-label-context">
&precedingPageNoVariable;
<report role="warning" id="chunk-title-starts-with-number" test="db:title[matches(., '^[0-9]')]">Title of "<value-of select="name(parent::element())"/>" starts with a number. Is it the label number? If so, it should probably be @label, &check_id; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

<pattern id="notes">
<title>Tests for notes section</title>
<rule context="db:info/db:title[contains(., 'Notes')][not(ancestor::db:book[@role='pdfOnly'])]" id="notes-context">
&precedingPageNoVariable;
<report test="not(ancestor::db:chapter[@role='notes'] or ancestor::db:section[@role='notes'])" role="warning" id="possible-notes-section">Title contains the string "Notes", but chunk ancestor does not have @role=notes. Is it a notes section? &check_ancestor; &pageNoAndChunkPDF;</report>
        <report test="(ancestor::db:chapter/processing-instruction(insert)[contains(., 'Notes')] or ancestor::db:article/processing-instruction(insert)[contains(., 'Notes')] or ancestor::db:section/processing-instruction(insert)[contains(., 'Notes')])" id="notes-pi-title">Title contains 'Notes', but there is also a PI containing 'Notes'; remove the title="Notes" from the PI, &check_ancestor; &pageNoAndChunkPDF;</report>
</rule>
<rule context="db:chapter[@role='notes']" id="ch-notes-context">
&precedingPageNoVariable;
<assert test="processing-instruction(insert)[contains(., 'end-bk-notes')]" id="end-bk-notes-missing"><name/> has @role=notes but does not contain an end-bk-notes PI, &check_id; &pageNoAndChunkPDF;</assert>
</rule>
<rule context="db:section[@role='notes']" id="section-notes-context">
&precedingPageNoVariable;
<assert test="processing-instruction(insert)[contains(., 'end-ch-notes')]" id="end-ch-notes-missing"><name/> has @role=notes but does not contain an end-ch-notes PI, &check_id; &pageNoAndChunkPDF;</assert>
        <report test="processing-instruction(insert)[contains(., 'end-ch-notes') and contains(., 'title=')]" id="end-ch-notes-title"><name/> has @role=notes and end-ch-notes PI, but the latter also contains 'title=...' which is not correct, &check_id; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

<!-- This doesn't work yet 
<pattern id="pdf-chunks">
<rule context="&chunk_blocks;">
<assert test="db:abstract">Chunk blocks in pdf only books must contain an abstract. See &named_element_with_id;</assert>
</rule>
</pattern>
-->

<pattern id="pdf-only">
<title>Tests specific to PDF-only titles</title>
<rule context="db:book[@role='pdfOnly']//db:abstract[not(parent::db:info/parent::db:book[@role='pdfOnly'])]" id="pdf-specific-context">
<assert test="@role='extract'" id="pdf-only-extract">The chunk abstract in the pdf-only title must be an @role=extract, &check_id;</assert>
</rule>
<rule context="db:dedication[ancestor::db:book[@role='pdfOnly']]" id="pdf-ded-context">
<report test="db:para" id="para-dedication-pdfonly">Text content is not required in pdf-only books; the only content should be the standard remark, &check_id;</report>
</rule>
</pattern>

<pattern id="chunks-and-dois">
<title>Tests to ensure that chunks that require DOIs have them, and that those that don't need them don't, and that where they are present their format is correct</title>
<!-- There is only one element that usually requires a DOI -->
        <rule context="db:chapter[not(ancestor::db:book/db:info/db:biblioid[@otherclass='DOInotRequired'] = '1')]" id="chunk-doi-context">
<assert test="db:info/db:biblioid[@class='doi']" id="chunk-doi-present">Block must contain a DOI &named_element_with_id;</assert>
</rule>
        <rule context="db:preface | db:toc | db:bibliography | db:appendix | db:glossary | db:acknowledgements | db:index" id="no-doi-context">
                <let name="oldDoi" value="if (ancestor::db:book[//db:chapter/db:info[starts-with(db:biblioid[@class='doi'], '10.2752')]]) then 1 else 0" />
                <report test="if ($oldDoi=1) then 0 else (db:info/db:biblioid[@class='doi'])" id="doi-not-required">Block must not contain a DOI. See &named_element_with_id;</report>
        </rule>
        <rule context="db:part[not(ancestor::db:book/db:info/db:biblioid[@otherclass='DOInotRequired'] = '1')]" id="part-doi-context">
<report test="not(db:info/db:mediaobject/db:imageobject[@role='suppressPDF']) and not(@role='front' or @role='back') and not(db:info/db:title[@outputformat='e-Only'] or db:info/db:title[@role='keepWithNext']) and not(db:info/db:biblioid[@class='doi'])" id="part-doi-required">A part with content (ie with no suppress PDF flag) must have a DOI, &check_id;</report>
<report test="db:info/db:mediaobject/db:imageobject[@role='suppressPDF'] and db:info/db:biblioid[@class='doi']" id="part-no-doi">A part with suppress PDF must not have a DOI, &check_id;</report>
</rule>
</pattern>

<pattern id="chunk-and-dois2">
        <title>Other DOI tests</title>
        <rule context="db:chapter[ancestor::db:book/db:info/db:biblioid[@otherclass='DOInotRequired'] = '1'] | db:book[db:info/db:biblioid[@otherclass='DOInotRequired'] = '1']" id="chunk-doi-context2">
                <report test="db:info/db:biblioid[@class='doi']" id="chunk-doi-not-required">If book is flagged 'DOInotRequired', book must not contain a DOI &named_element_with_id;</report>
        </rule>
</pattern>

<pattern id="info-issues">
<title>The info block should only contain key metadata in a small number of contexts</title>
        <rule context="db:info/db:biblioid[@class='doi'][not(ancestor::db:book[//db:chapter/db:info[starts-with(db:biblioid[@class='doi'], '10.2752')]])]" id="info-doi-context">
                <report test="&pathsWithoutInfoMetaItems-core; and not(parent::db:info/parent::db:section[@role='subArticle'])" id="doi-not-req">A DOI is not required in this location, &check_ancestor;</report>
</rule>
<rule context="db:info/db:pagenums" id="info-pagenums-context">
<report test="&pathsWithoutInfoMetaItems-all;" id="pagenums-not-req">pagenums is not required in this location, &check_ancestor;</report>
</rule>
<rule context="db:info/db:mediaobject" id="info-mediaobject-context">
<report test="&pathsWithoutInfoMetaItems-all;" id="mediaobject-not-req">mediaobject is not required in this location, &check_ancestor;</report>
</rule>
        <rule context="db:info[db:biblioid[@otherclass='biblioType']]" id="info-bibliotype-context">
                <assert test="parent::db:bibliography or parent::db:chapter or parent::db:book" id="bibliotype-not-req">A biblioType is not permitted in this location, &check_ancestor;</assert>
        </rule>
</pattern>

<pattern id="chunk-doi-label">
<title>Rules relating to chunk DOIs and @label</title>
<rule context="db:chapter" id="ch-doi-context">
<let name="DOIAfterPrefix" value="substring-after(db:info/db:biblioid[@class='doi'], '/')"/>
<let name="DOIAfterISBN" value="substring-after($DOIAfterPrefix, '.')"/>
<report test="starts-with($DOIAfterISBN, 'ch') and not(@label)" id="ch-doi-no-label" role="warning">There is a chapter-like DOI, but no @label on the chapter. &check_id;</report>
</rule>
<rule context="db:part[db:chapter[@label]]" id="part-label-context">
<report test="not(@label)" role="warning" id="part-no-label">A 'part' contains numbered chapters, but the part does not have a @label, OK? &check_id;</report>
</rule>
</pattern>

<pattern id="chunk-part-label">
<title>Another test for parts with missing @labels</title>
<rule context="db:part[not(db:info/db:biblioid[@otherclass='taxonRank'])]" id="part-label-context-2">
<let name="FilenameAfterPrefix" value="substring-after(db:info/db:mediaobject/db:imageobject/db:imagedata/@fileref, '/')"/>
<let name="FilenameAfterISBN" value="substring-after($FilenameAfterPrefix, '.')"/>
<report test="starts-with($FilenameAfterISBN, 'part') and not(@label)" id="part-filename-no-label" role="warning">There is a part-like filename, but no @label on the chapter. &check_id;</report>
</rule>
</pattern>

<pattern id="chunk-doi-print">
<title>Rules relating to chunk DOIs that are dependent on whether a book is e-only or if there is a print edition</title>
        <rule context="db:chapter[not(ancestor::db:book[@outputformat='e-Only'])][not(starts-with(db:info/db:biblioid[@class='doi'], '10.2752'))]" id="doi-eonly-context">
<let name="DOIAfterPrefix" value="substring-after(db:info/db:biblioid[@class='doi'], '/')"/>
<let name="filename" value="substring-after(db:info/db:mediaobject/db:imageobject/db:imagedata/@fileref, '/')"/>
<let name="filenameWithoutExtension" value="substring-before($filename, '.pdf')"/>
<assert test="$DOIAfterPrefix = $filenameWithoutExtension" id="non-matching-doi-pdf">DOI and pdf filename do not match (<value-of select="$DOIAfterPrefix"/>, <value-of select="$filenameWithoutExtension"/>. &check_id;</assert>
</rule>
</pattern>

<pattern id="parts-with-no-content-other-than-chunks">
<title>Front and back matter containers and Part containers with no chapter content have some special rules for their metadata</title>
<rule context="db:part[@role='front']" id="front-context">
<report test="db:info/db:pagenums" id="no-pagenums-front">Front matter container must not contain page numbers &named_element_with_id;</report>
<report test="db:info/db:biblioid[@class='doi']" id="no-doi-front">Front matter container must not contain DOI &named_element_with_id;</report>
<!-- Tighten once sorted out mime type -->
<report test="db:info/db:mediaobject" id="no-pdf-front">Front matter container must not contain PDF file ref &named_element_with_id;</report>
</rule>
<rule context="db:part[@role='back']" id="back-context">
<report test="db:info/db:pagenums" id="no-pagenums-back">Back matter container must not contain page numbers &named_element_with_id;</report>
<report test="db:info/db:biblioid[@class='doi']" id="no-doi-back">Back matter container must not contain DOI &named_element_with_id;</report>
<!-- Tighten once sorted out mime type -->
<report test="db:info/db:mediaobject" id="no-pdf-back">Back matter container must not contain PDF file ref &named_element_with_id;</report>
</rule>
<rule context="db:part[not(db:partintro or db:article) and not(@role='front') and not(@role='back') and not(db:info/db:title[@outputformat='e-Only'] or db:info/db:title[@role='keepWithNext'])]" id="part-context-a">
<report test="db:info/db:abstract[not(contains(., 'No extract of this content is available for preview'))] and db:info/db:mediaobject[db:imageobject[@role='suppressPDF']]" id="part-abstract">A part with no content other than chapters/articles, partintro must not have an abstract. &check_id;</report>
<report test="db:info/db:abstract[contains(., 'No extract of this content is available for preview')] and not(db:info/db:mediaobject/db:imageobject[@role='suppressPDF'])" id="part-suppress-pdf">A part with no content other than chapters/articles/partintro must have @role=suppressPDF on imageobject. &check_id;</report>
<report test="if (not(ancestor::db:book[@outputformat='e-Only'])) then not(db:info/db:mediaobject/db:imageobject[@role='suppressPDF']) and not(db:info/db:abstract) else 0" id="suppress-pdf-required">Part divisions with no content other than chunks must have a suppress PDF flag on the imageobject &named_element_with_id;</report>
<report test="db:info/db:mediaobject/db:imageobject[@role='suppressPDF'] and db:info/db:abstract[not(contains(., 'No extract of this content is available for preview'))]" id="suppress-pdf-abstract">Part divisions with an abstract must not have a suppress PDF flag on the imageobject, &named_element_with_id;</report>
<report test="not(db:chapter or db:article or db:part)" role="warning" id="no-chs-in-part">A Part does not have any chapters or articles within it, OK? &check_id;</report>
</rule>
<rule context="db:part[db:partintro]" id="partintro-context">
<report test="db:info/db:mediaobject/db:imageobject[@role='suppressPDF']" id="suppress-pdf-partintro">Part divisions with a partintro must not have a suppress PDF flag on the imageobject &named_element_with_id;</report>
</rule>
        <rule context="db:part[db:article][not(ancestor::db:book/db:info/db:biblioid[@otherclass='DOInotRequired'] = '1')]" id="part-article-context">
<report test="db:info/db:mediaobject/db:imageobject[@role='suppressPDF']" id="suppress-pdf-article">Part divisions with child articles must not have a suppress PDF flag on the imageobject &named_element_with_id;</report>
<assert test="db:info/db:biblioid[@class='doi']" id="part-article-doi">Part divisions with child articles must have a DOI, &check_id;</assert>
</rule>
</pattern>

<pattern id="articles">
<title>Tests for articles, ie A-Z content</title>
        <rule context="db:article[not(ancestor::db:book/db:info/db:biblioid[@otherclass='DOInotRequired'] = '1')]" id="article-context1">
&precedingPageNoVariable;
<assert test="db:info/db:biblioid[@class='doi']" id="article-doi">An article must have a DOI, &check_id;</assert>
        <report test="descendant::db:emphasis[@role='bold'][not(db:link or parent::db:link)][not(matches(.,'^See also'))] or descendant::db:emphasis[@role='smallcaps'][not(db:link or parent::db:link)][not(matches(.,'^See also')) and not(matches(.,'^b.c.e')) and not(matches(.,'^c.e')) and not(matches(.,'^b.c')) and not(matches(.,'^a.d'))]" role="warning" id="possible-article-link">An article contains bold/smallcaps that is not linked. Should it be a cross reference to another article? &check_id; &pageNoAndChunkPDF;</report>
<report test="@role='snapshotArticle'" id="snapshot-article" role="info">A snapshot article is present, &check_id;</report>
</rule>
<rule context="db:title[@role='keepWithNext']" id="keep-context">
&precedingPageNoVariable;
<assert test="(parent::db:info/parent::db:part and parent::db:info/parent::db:part/db:part/db:article) or parent::db:info/parent::db:part and not(parent::db:info/db:pagenums)" id="keep-with-next">The title[@role=keepWithNext] should only be used for parent titles in some contexts in some A-Z reference works OR where the Part heading is on the same page as the first child chapter, &check_id; &pageNoAndChunkPDF;</assert>
<report test="parent::db:info/db:pagenums" id="keep-with-next-pagenums">If a title has @role=keepWithNext, it MUST NOT have a sibling pagenums, &check_id;</report>
<report test="parent::db:info/db:mediaobject" id="keep-with-next-mediaobject">If a title has @role=keepWithNext, it MUST NOT have a sibling mediaobject, &check_id;</report>
</rule>
<rule context="db:article/db:para[1][not(@role='see')][string-length() gt 0]" id="see-context">
&precedingPageNoVariable;
<report test="(string-length(db:link[@linkend][1]) + string-length(db:link[@linkend][2]) + string-length(db:link[@linkend][3]) + string-length(db:link[@linkend][4]) + string-length(db:link[@linkend][5]) + string-length(db:link[@linkend][6]) + string-length(db:link[@linkend][7]) + string-length(db:link[@linkend][8])) div string-length() gt 0.5" role="warning" id="article-para-links">A para in an article is comprised mostly of internal links, should the para have @role=see? &check_id; &pageNoAndChunkPDF;</report>
</rule>
<rule context="db:section[db:bibliolist][ancestor::db:article]" id="article-section-context">
<assert test="@role='bibliography'" id="article-section-role">A <name/> containing a bibliolist in an article must have @role=bibliography; &check_id;</assert>
</rule>
<rule context="db:phrase[@role='origin'] | db:phrase[@role='pronunciation'] | db:phrase[@role='synonym'] | db:bibliomisc[@role='category']" id="article-element-context">
<assert test="ancestor::db:article" id="article-element-type">A <name/> with @role=<value-of select="@role"/> should only occur within an article, &check_ancestor;</assert>
</rule>
<rule context="db:section[@role='subArticle']" id="article-section-context-2">
&precedingPageNoVariable;
<assert test="ancestor::db:article" role="warning" id="subarticle-test">A section with @role=subArticle should usually be in an article. Is this correct? &check_id; &pageNoAndChunkPDF;</assert>
<report test="@role='subArticle'" id="sub-article" role="info">A sub article is present, &check_id; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

<pattern id="articles2">
<title>More tests for articles and A-Z content</title>
<rule context="db:article[not(@role='xref')]" id="article-context-2">
&precedingPageNoVariable;
<report test="(string-length(descendant::db:link[@linkend][1]) + string-length(descendant::db:link[@linkend][2]) + string-length(descendant::db:link[@linkend][3]) + string-length(descendant::db:link[@linkend][4]) + string-length(descendant::db:link[@linkend][5]) + string-length(descendant::db:link[@linkend][6]) + string-length(descendant::db:link[@linkend][7]) + string-length(descendant::db:link[@linkend][8])) div string-length() gt 0.1" id="article-xref" role="warning">An article is comprised mostly of internal links, should it have @role=xref? &check_id; &pageNoAndChunkPDF;</report>
</rule>
<rule context="db:article[@role='xref']" id="article-context-3b">
&precedingPageNoVariable;
<report test="count(db:para) gt 1" id="article-xref-2" role="warning">An article has @role=xref (ie is marked as a cross-reference article), but contains multiple paragraphs, so probably shouldn't have @role=xref? &check_id; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

<pattern id="articles3">
<title>Page numbers in articles</title>
<rule context="db:article[not(matches(@outputformat,'e-Only'))]" id="article-context-3a">
<assert test="db:info/db:pagenums" id="article-pagenums">An article must have pagenums, &check_id;</assert>
</rule>
</pattern>

<pattern id="articles4">
<title>FPA articles</title>
<rule context="db:article/db:info[starts-with(substring-after(db:biblioid[@class='doi'], '10.5040/9781474260428-'), 'FPA')]" id="fpa-context1">
<assert test="db:biblioid[@otherclass='fpaArticleType']" id="fpa-article-type">An FPA article must have an FPA article type, &check_id;</assert>
</rule>
<rule context="db:article/db:info[starts-with(substring-after(db:biblioid[@class='doi'], '10.5040/9781474260428-'), 'FPA')]/db:biblioid[@otherclass='fpaArticleType']" id="fpa-context2">
<assert test="matches(., '^Biography$') or matches(., '^Color$') or matches(., '^Couture Shows$') or matches(., '^Curator’s Guide$') or matches(., '^Decades$') or matches(., '^Fashion Icon$') or matches(., '^Fashion City$') or matches(., '^Garments and Accessories$') or matches(., '^Icon$') or matches(., '^Key Collection$') or matches(., '^Lesson Plan$') or matches(., '^Overview$') or matches(., '^Scholar’s Guide$') or matches(., '^Single Object Study$') or matches(., '^Student Exercise$') or matches(., '^Subcultural Style$') or matches(., '^Theme$')" id="fpa-typology">An FPA article type must match one of the permitted values (= <value-of select="."/>), &check_ancestor;</assert>
</rule>
</pattern>

<pattern id="articles5">
<rule context="db:biblioid[@otherclass='fpaArticleType'][not(ancestor::db:article/db:info[starts-with(substring-after(db:biblioid[@class='doi'], '10.5040/9781474260428-'), 'FPA')])]" id="fpa-context3">
<report test="." id="invalid-fpa">An FPA article type can only occur within an FPA article, &check_ancestor;</report>
</rule>
</pattern>

<pattern id="first-elements">
<title>The first elements in the book after info must be colophon (optional) and part[@role=front]</title>
        <rule context="db:book/db:info[not(db:biblioid[@otherclass='specialBookType'] = 'bflBiblioGuide') and not (parent::db:book/@outputformat='e-Only')]" id="beginning-context">
<assert test="following-sibling::*[1][self::db:colophon] or following-sibling::*[1][self::db:part[@role='front']]" id="first-element-after-info">First element after book/info must be colophon or front matter container</assert>
</rule>
<rule context="db:book/db:colophon" id="colophon-context">
<assert test="following-sibling::*[1][self::db:part[@role='front']]" id="first-element-after-colophon">First element after colophon must be front matter container</assert>
</rule>
</pattern>

<pattern id="front-matter">
<title>Content and structure of the front matter container</title>
<rule context="db:part[@role='front']" id="front-context-2">
<assert test="db:info/db:title[text()='Front matter']" id="front-matter-title">The title of the front matter must be "Front matter" &check_id;</assert>
<assert test="db:info/following-sibling::*[1][self::db:preface[@role='prelims']]" id="first-element-front">The first element in front matter after info must be the prelims. &check_id; </assert>
<assert test="db:toc" id="toc-present" role="warning">The front matter should usually contain a contents chunk (toc). &check_id;</assert>
</rule>
<rule context="db:preface[@role='prelims']" id="prelims-context">
<assert test="db:info/db:title[text()='Title Pages']" id="prelims-title">The title of the prelims must be "Title Pages" &check_id;</assert>
<report test="db:info/db:subtitle" id="prelims-subtitle">A subtitle is present in the prelims, which is not allowed, &check_id;</report>
</rule>
</pattern>

<pattern id="content-that-should-be-in-front-matter">
<title>Some chunks really should be in the front matter</title>
<rule context="db:preface|db:toc" id="front-context-3">
<assert test="parent::db:part[@role='front']" id="front-chunk">The chunk "<name/>" must be in the front matter container &check_id;</assert>
</rule>
<rule context="db:dedication" id="front-context-4">
        <assert test="parent::db:part[@role='front']" id="front-chunk-dedication" role="warning">The chunk "<name/>" should normally be in the front matter container &check_id;</assert>
</rule>
<rule context="db:acknowledgements" id="ack-context">
<assert test="parent::db:part[@role='front'] or parent::db:part[@role='back']" id="acknowledgements-chunk">The chunk "<name/>" must be in either the front or back matter container &check_id;</assert>
</rule>
</pattern>
        
<pattern id="book-level-dedication">
<title>Occasionally there might be a dedication just before back matter.</title>       
<rule context="db:book/db:dedication" id="book-dedication">
<assert test="following-sibling::*[1][self::db:part[@role='back']]" id="dedication-last-before-back">The chunk "<name/>" must be in last position before the back matter container, when it occurs directly within the book &check_id;</assert>   
</rule>
</pattern>

<pattern id="content-that-should-be-in-back-matter">
<title>Some chunks really should be in the back matter</title>
<rule context="db:appendix|db:index" id="back-context-3">
<assert test="parent::db:part[@role='back']" id="back-chunk" role="warning">The chunk "<name/>" should normally be in the back matter container &check_id;</assert>
</rule>
</pattern>

<pattern id="back-content">
<title>Content and structure of the back matter</title>
<rule context="db:part[@role='back']" id="back-context-2">
<assert test="db:info/db:title[text()='Back matter']" id="back-matter-title">The title of the back matter must be "Back matter" &check_id;</assert>
</rule>
</pattern>

<pattern id="front-title-content">
<title>Lists of illustrations etc need to be in toc elements</title>
<rule context="db:part[@role='front']/element()[not(self::db:toc)]" id="illus-context">
<report role="warning" id="title-starts-with-list" test="contains(db:info/db:title, 'List')">Chunk in the front matter includes the word 'List' in its title but is not a toc element, OK? &check_id;</report>
</rule>
</pattern>

<pattern id="toc-items-with-numbers">
<title>Chapter and Part numbers etc in the ToC must not be captured in the data</title>
<rule context="db:toc//db:member" id="toc-member-context">
<report role="warning" id="toc-list-starts-with-number" test="matches(., '^[0-9]')">List item in a toc starts with a number. Is it the target label number? If so, it should be deleted, &check_id;</report>
</rule>
</pattern>


	<pattern id='should_not_be_empty'>
<title>Some significant elements should never be empty (eg empty para and empty title are not allowed)</title>
<!-- added constraint on context for para else paras  with only elements in lists were getting picked up -->
		<rule context='db:title | db:para[not(element()) and not(parent::db:entry)]' id="empty-context">
&precedingPageNoVariable;
			<assert role="error" test='string-length(normalize-space(.)) != 0' id="impermissible-empty-element">The &named_element_with_id; should have some content or be deleted [if vertical white space is required, it must be controlled by methods specified], &check_id; &pageNoAndChunkPDF;</assert>
                                <report test="matches(.[not(ancestor::db:index)], '^&#x00A0;+$') or matches(.[not(ancestor::db:index)], '^&#x2000;+$') or matches(.[not(ancestor::db:index)], '^&#x2001;+$') or matches(.[not(ancestor::db:index)], '^&#x2002;+$') or matches(.[not(ancestor::db:index)], '^&#x2003;+$') or matches(.[not(ancestor::db:index)], '^&#x2004;+$') or matches(.[not(ancestor::db:index)], '^&#x2005;+$') or matches(.[not(ancestor::db:index)], '^&#x2006;+$') or matches(.[not(ancestor::db:index)], '^&#x2007;+$') or matches(.[not(ancestor::db:index)], '^&#x2008;+$') or matches(.[not(ancestor::db:index)], '^&#x2009;+$') or matches(.[not(ancestor::db:index)], '^&#x200A;+$') or matches(.[not(ancestor::db:index)], '^&#x200B;+$') or matches(.[not(ancestor::db:index)], '^&#x200C;+$') or matches(.[not(ancestor::db:index)], '^&#x200D;+$') or matches(.[not(ancestor::db:index)], '^&#x202F;+$') or matches(.[not(ancestor::db:index)], '^&#x205F;+$')" id="only-contains-nbsp">Element (<name/>) only contains space elements, which is not allowed; if vertical white space is required, it must be controlled by attributes on the element, &check_id; &pageNoAndChunkPDF;</report>
		</rule>
	</pattern>
	
<!-- Paragraph checks -->
<pattern id="paras">
<title>Tests relating to various paragraph components</title>
<rule context="db:bibliolist[not(@role)]" id="bibliolist-context">
&precedingPageNoVariable;
<report test="parent::db:para" id="inline-bibliolist">Bibliolist within para should have @role=inline, &check_id; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

        <pattern id="biblists">
                <title>Bibliolists not in paras</title>
                <rule context="db:bibliolist[@role='inline']" id="inline-bibliolist-context">
                        &precedingPageNoVariable;
                        <assert test="parent::db:para" id="non-inline-bibliolist">An inline bibliolist that is not within para is not permitted. Is it really inline?, &check_id; &pageNoAndChunkPDF;</assert>
                </rule>
        </pattern>

        <!-- Bridgehead checks -->
        <pattern id="bridgeheads">
                <title>Tests relating to bridgehead elements</title>
                <rule context="db:bridgehead" id="bridgehead-context">
                        &precedingPageNoVariable;
                        <report test="(parent::db:chapter or parent::db:partintro or parent::db:section or parent::db:preface or parent::db:appendix or parent::db:article) and not(ancestor::db:book/db:info/db:biblioid[@otherclass='legalContentType'] = 'cases')" id="bridgehead-location" role="warning">A <name/> should not normally be a child of an element that can take sections. Use section/info/title for the heading and properly next the content in a section instead, &check_id; &pageNoAndChunkPDF;</report>
                        <assert test="@renderas" id="bridgehead-renderas">A <name/> must have a @renderas attribute, the value of which (sect1, sect2 etc) must be equivalent to the nesting level of the corresponding heading style, &check_id; &pageNoAndChunkPDF;</assert>
                        <report test="@role" id="bridgehead-role">A <name/> must not have @role; use the DocBook standard @renderas for determining how the bridgehead needs to be styled, &check_id; &pageNoAndChunkPDF;</report>
                        <assert test="if (parent::db:note[@role='annotations']) then (@renderas='sect3') else 1" id="bridgehead-annotations">A bridgehead in a note[@role=annotations] must have @renderas=sect3, &check_id;</assert>
                </rule>
        </pattern>
        
	<!-- List checks -->
	<pattern id="list-checks">
<title>List tests</title>
		<rule context="db:itemizedlist[not(db:title) and not(db:info/db:title)]" id="itemizedlist-context">
&precedingPageNoVariable;
			<assert role="warning" test="count(db:listitem) gt 1" id="single-list-item">The &named_element_with_id; has only one list item. Is this correct? &pageNoAndChunkPDF;</assert>
		</rule>
		<rule context="db:itemizedlist" id="check-titled-itemized-lists-for-single-entry">
&precedingPageNoVariable;
			<assert role="warning" test="count(db:listitem) gt 1" id="single-list-item-2">The &named_element_with_id; has only one list item and a title. Should this be a formal paragraph? &pageNoAndChunkPDF;</assert>
		</rule>
        <rule context="db:orderedlist" id="orderedlist-context">
&precedingPageNoVariable;
            <report test="@continuation" role="information" id="continuation-present"><name/> has @continuation, &check_id; &pageNoAndChunkPDF;</report>
            <report test="@numeration" role="information" id="numeration-present"><name/> has @numeration = <value-of select="@numeration"/>, &check_id; &pageNoAndChunkPDF;</report>
            <report test="@startingnumber" role="information" id="startingnumber-present"><name/> has @startingnumber = <value-of select="@startingnumber"/>, &check_id; &pageNoAndChunkPDF;</report>
            <report test="@inheritnum" role="information" id="inheritnum-present"><name/> has @inheritnum = <value-of select="@inheritnum"/>, &check_id; &pageNoAndChunkPDF;</report>
        </rule>
        <rule context="db:varlistentry" id="varlistentry-context">
&precedingPageNoVariable;
            <report test="db:term[2]" role="warning" id="multi-terms">Multiple terms in varlistentry. Is that correct? &check_ancestor; &pageNoAndChunkPDF;</report>
        </rule>
	</pattern>

<pattern id="itemized-list-type">
<title>Itemized or bulleted lists can control the bullet style to some extent</title>
<rule context="db:itemizedlist[@mark]" id="mark-context">
&precedingPageNoVariable;
<assert test="@mark='disc' or @mark='square' or @mark='circle' or @mark='none'" id="list-mark">@mark MUST usually be one of disc, square, circle. If no mark is required, use simplelist unless the list has a title &check_id; &pageNoAndChunkPDF;</assert>
</rule>
</pattern>

<pattern id="lists">
<title>General list tests</title>
<rule context="db:simplelist | db:itemizedlist | db:orderedlist | db:variablelist | db:glosslist" id="all-lists-context">
&precedingPageNoVariable;
<report role="warning" id="list-para-test" test="parent::db:para[not(ancestor::db:abstract) and not(ancestor::db:book/db:info/db:biblioid[@otherclass='legalContentType'])]">Element '<name/>' is within a paragraph, which is almost certainly not correct, &check_id; &pageNoAndChunkPDF;</report>
<report test="parent::db:listitem" role="information" id="nested-list">Element '<name/>' is nested within a listitem, &check_id; &pageNoAndChunkPDF;</report>
</rule>
</pattern>
	
	<!-- Basic checks on images and other objects -->
	<pattern id='image_checks_1'>
<title>Image components</title>
<!-- This will need to be modified once other mediaobjects are included (eg video, audio) -->
		<rule context='db:mediaobject|db:inlinemediaobject' id="object-context">
			<assert role='error' test='count(db:imageobject) gt 0' id="imageobject-required"><name/> elements must contain at least one "imageobject" element.</assert>
                               <report test="(count(db:imageobject) = 1) and (db:imageobject/db:imagedata[@format='image/tiff'] or db:imageobject/db:imagedata[@format='image/eps'])" id="only-non-web-image">Image has only a version in a non-web image format, which is not correct, &ancestor_id;</report>
			<assert role='error' test='db:imageobject/db:imagedata/@format' id="imagedata-format-required">"imagedata" elements must have a "format" attribute.</assert>	
<!--			<assert role='error' test='count(distinct-values(db:imageobject/db:imagedata/@format)) = count(db:imageobject)'>The "format" attributes of the "imagedata" elements must be unique within a single "mediaobject".</assert>-->
		</rule>
	</pattern>
        
        <pattern id="inlinemediaobjects">
                <title>Inline media objects</title>
                <rule context="db:title" id="inlinemediaobject-context1">
                        <report test="descendant::db:inlinemediaobject" role="warning" id="imo-title">A <name/> contains an inlinemediaobject, which is unlikely to be right, &check_id;</report>
                </rule>
                <rule context="node()" id="inlinemediaobject-context2">
                        <report test="db:inlinemediaobject" role="information" id="imo-present">An inlinemediaobject is present, &check_ancestor;</report>
                </rule>
        </pattern>
	
	<pattern id='image_checks_2'>
<title>MIME type of image (and other) objects</title>
		<rule context='db:imagedata' id="image-context">
            <assert test="@format='image/eps' or @format='image/png' or @format='image/tiff' or @format='image/gif' or @format='image/jpeg' or @format='application/pdf'" id="imagedata-mime-type">image objects must have a @format which is a valid MIME type. &check_ancestor;</assert>
            <report test="@outputformat='web' and (@format='image/eps' or @format='image/tiff')" id="non-web-image-format">image has @format=<value-of select="@format"/> AND @outputformat=web, which is not correct. &check_ancestor;</report>
		</rule>			
	</pattern>
	
	<pattern id='image_checks_3'>
<title>Relative locations of associated files (pdfs, images etc)</title>
		<rule context='db:imagedata[@format="application/pdf"]' id="pdf-context">			
            <assert test="starts-with(@fileref, 'pdfs/')" id="pdf-dir">PDF files must be located within a pdfs/ directory. &check_ancestor;</assert>
		</rule>			
		<rule context='db:imagedata[@format="image/png"] | db:imagedata[@format="image/tiff"] | db:imagedata[@format="image/gif"] | db:imagedata[@format="image/jpeg"]' id="images-context">			
            <assert test="starts-with(@fileref, 'images/')" id="images-dir">Images files must be located within an images/ directory. &check_ancestor;</assert>
		</rule>			
	</pattern>

<pattern id="image_filetype">
<title>Tests for image file extensions</title>
<rule context="db:imagedata[@format='application/pdf']" id="pdf-ext-context">
<assert test="ends-with(@fileref, '.pdf')" id="pdf-file-extension">PDF files must have a .pdf file extension, &check_ancestor;</assert>
</rule>
<rule context="db:imagedata[@format='image/png']" id="png-ext-context">
<assert test="ends-with(@fileref, '.png')" id="png-file-extension">Image files with MIME type <value-of select="@format"/> must have file extension .png, &check_ancestor;</assert>
</rule>
<rule context="db:imagedata[@format='image/tiff']" id="tiff-ext-context">
<assert test="ends-with(@fileref, '.tiff') or ends-with(@fileref, '.tif')" id="tiff-file-extension">Image files with MIME type <value-of select="@format"/> must have file extension .tiff or .tif, &check_ancestor;</assert>
</rule>
<rule context="db:imagedata[@format='image/gif']" id="gif-ext-context">
<assert test="ends-with(@fileref, '.gif')" id="gif-file-extension">Image files with MIME type <value-of select="@format"/> must have file extension .gif, &check_ancestor;</assert>
</rule>
<rule context="db:imagedata[@format='image/jpeg']" id="jpg-ext-context">
<assert test="ends-with(@fileref, '.jpg') or ends-with(@fileref, '.jpeg')" id="jpg-file-extension">Image files with MIME type <value-of select="@format"/> must have file extension .jpg or .jpeg, &check_ancestor;</assert>
</rule>
</pattern>

	<pattern id='image_checks_4'>
<title>If multiple versions of the same image are present, then @outputformat must be specified for each</title>
		<rule context='db:mediaobject[count(db:imageobject) &gt; 1]/db:imageobject | db:inlinemediaobject[count(db:imageobject) &gt; 1]/db:imageobject' id="image-count-context">
			<assert role='error' test='db:imagedata[@outputformat]' id="outputformat-required">mediaobject elements with more than one "imageobject" element must have @outputformat specified on imagedata.</assert>
		</rule>
        <rule context="db:imagedata[@outputformat]" id="image-format-context">
            <assert test="@outputformat='web' or @outputformat='print'" id="outputformat-imagedata">The only permissible values of @outputformat on imagedata are 'web' or 'print', &check_ancestor;</assert>
        </rule>
	</pattern>

<pattern id="outputformat-condition-attributes">
<title>A @outputformat attribute is only allowed on specific elements, where they must take the values defined in the schema. If a @outputformat is included on any other element it is an error</title>
<rule context="*[@outputformat]" id="outputformat-context">
<report test="not(local-name() = $elements-with-outputformat )" id="outputformat-attribute">The <name/> element has a @outputformat attribute, but it is not an element on which it is allowed. &check_id;</report>
<report test="@outputformat" id="outputformat-present" role="information">The <name/> element has @outputformat=<value-of select="@outputformat"/>, &check_ancestor;</report>
</rule>
</pattern>

<pattern id="figures">
<title>General figure tests</title>
<rule context="db:informalfigure | db:figure" id="figure-context">
&precedingPageNoVariable;
<report id="figure-present" role="information" test="self::*">A <name/> is present, &check_id; &pageNoAndChunkPDF;</report>
<report test="string-length(db:info/db:title) - string-length(db:info/db:title/db:footnote) gt 100" role="warning" id="figure-title-length">The <name/> title is <value-of select="string-length(db:info/db:title) - string-length(db:info/db:title/db:footnote)"/> characters long, should some of it be in a caption? &check_id; &pageNoAndChunkPDF;</report>
<assert test="db:mediaobject" id="mediaobject-required">A mediaobject is required within a <name/>, &check_id;</assert>
</rule>
<rule context="element()[@role='source']" id="source-context">
&precedingPageNoVariable;
<assert test="ancestor::db:caption" id="source-in-caption">A <name/> element with @role=source can only be within a caption; &check_ancestor; &pageNoAndChunkPDF;</assert>
</rule>
</pattern>

<pattern id="fpa-figs">
<title>Tests specifically relating to FPA article images</title>
<rule context="db:mediaobject[starts-with(substring-after(ancestor::db:article/@xml:id, 'b-9781474260428-'), 'FPA')] | db:inlinemediaobject[starts-with(substring-after(ancestor::db:article/@xml:id, 'b-9781474260428-'), 'FPA')]" id="fpa-mediaobject-context">
<assert test="@role='fpa'" id="fpa-mediaobject">A <name/> in an FPA article must have @role=fpa, &check_id;</assert>
</rule>
</pattern>
        
<pattern id="singleton-imageobject">
<title>imageobject in mediaobject</title>
<rule context="db:mediaobject[every $x in db:imageobject/db:imagedata/@outputformat satisfies $x = 'web']" id="web-mediaobjects">
<assert test="count(db:imageobject) = 1" id="singleton-web-imageobject">A <name/> must have only one imageobject child with imagedata/@outputformat='web'.</assert>
</rule>        
</pattern>        

<!-- Paragraphs containing blocks -->
<pattern id="bibliolists-in-footnotes">
<title>Inline bibliolists in footnotes</title>
<rule context="db:footnote/db:bibliolist" id="fn-bibl-context">
&precedingPageNoVariable;
<report test="@role='inline'" id="inline-bibliolist-footnote">A <name/> as the only child of footnote must not have @role=inline, &check_id; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

	<pattern id='para_block_checks'>
<title>Paragraphs shouldn't normally *directly* contain just one block element. And, if they only contain a single inline element, it may make more sense to replace both and use the block equivalent</title>
		<rule context='*[local-name() = $all-blocks]' id="block-context">
&precedingPageNoVariable;
			<report role='warning' test="local-name(..) = 'para' and count(../node()) = 1" id="para-single-block">The block &named_element_with_id; is the only direct child of a paragraph. &pageNoAndChunkPDF;</report>
		</rule>
		<rule context='db:inlinemediaobject|db:inlinequation' id="inline-context">
&precedingPageNoVariable;
			<report role='warning' test="local-name(..) = 'para' and count(../node()) = 1" id="convert-inline-to-block">The "<name/>" element contained in para with id "<value-of select="../@id"/>" should be replaced with the block equivalent. &pageNoAndChunkPDF;</report>
		</rule>
	</pattern>

	<!-- LINK CHECKING -->	
	<pattern id='link-checks'>
<title>Checking of link targets</title>
		<!-- link checks
			1) Ensure that links have either a linkend or an xlink:href attribute
			2) Ensure that links with a linkend attribute have an existing target.
			NB - the second check is in a new pattern below to avoid the rule being skipped.
            3) Check if link has unbalanced brackets within
		-->
		<rule context='db:link' id="link-context">
&precedingPageNoVariable;
            <report test="@role and (ancestor::db:book/db:info/db:biblioid[@otherclass='schematronVersion'] eq '1')" id="link-role-version"><name/> has @role, yet book/info/biblioid[@otherclass=schematronVersion] = 1; if @role is used, schematronVersion must be 2 or more, &check_ancestor;</report>
			<assert test='count(@linkend | @xlink:href) = 1' id="linkend-or-href">"link" elements must have either a "linkend" or a "xlink:href" attribute but not zero or both; &check_ancestor;</assert>
			<report test='contains(@xlink:href, " ")' id="whitespace-in-href">"xlink:href" attributes should not contain whitespace - check the URI and escape as specified in RFC 2396 (ie spaces should be replaced with '%20'); &check_ancestor; &pageNoAndChunkPDF;</report>
            <report test="contains(.,'(') and not(contains(.,')'))" id="unbalanced-brackets-1">"link" element contains only one bracket, which suggests that the span isn't correct, &check_ancestor; &pageNoAndChunkPDF;</report>
            <report test="contains(.,')') and not(contains(.,'('))" id="unbalanced-brackets-2">"link" element contains only one bracket, which suggests that the span isn't correct, &check_ancestor; &pageNoAndChunkPDF;</report>
            <report test="matches(., '‘.*’.*\(.*\)')" id="suspicious-link-content" role="warning">"link" element contains quotes and brackets, which suggests that its content may be too long, &check_ancestor; &pageNoAndChunkPDF;</report>
            <report test="string-length() >150 and not(db:uri) and not(db:alt)" id="long-link-content" role="warning">"link" element is longer than 150 characters, which suggests that its content may be too long, &check_ancestor; &pageNoAndChunkPDF;</report>
			<assert test='string-length(normalize-space(.)) != 0' id="empty-link">The link element MUST have some content, &check_ancestor;</assert>
            <report test="@endterm" id="endterm-present">@endterm on link is not permitted in this instance of DocBook, &check_ancestor;</report>
            <report test="parent::db:title and string-length()=1 and not(parent::db:superscript or child::db:superscript)" role="warning" id="short-link-text">Link text in title is only one character long. Does it need to be in a superscript? &ancestor_id; &pageNoAndChunkPDF;</report>
		</rule>
	</pattern>
	
	<!-- this pattern contains additional checks that would not be executed because of the "first matching rule" rule of schematron processing -->
	<pattern id="additional-link-checks">
<title>Link target must exist (though this is ensured by the schema anyway)</title>
		<rule context='db:link[@linkend]' id="linkend-context">
			<assert test='id(@linkend)' id="no-link-target">"link" elements must refer to an existing target, link referencing "<value-of select='@linkend'/>" does not.</assert>
			<assert test="local-name(&match_linkend;) != 'title'" id="link-target-title">link elements must not point to "title" elements; they should point to parent bibliomixed &ancestor_id;.</assert>
		</rule>
	</pattern>

<pattern id="additional-link-checks-2">
<title>Tests when links are not to other files within the data package</title>
<rule context="db:link[not(@role='relative')]" id="link-not-relative">
<assert test='count(@role | @xlink:href) le 1' id="role-or-href">"link" elements must have either a "role" or a "xlink:href" attribute but not both; &check_ancestor;</assert>
</rule>
</pattern>

<pattern id="additional-link-checks-3">
<title>Tests when links are to other files within the data package</title>
<rule context="db:link[@role='relative']" id="link-relative">
<assert test='@xlink:href' id="relative-href">relative "link" elements must have a "xlink:href" attribute; &check_ancestor;</assert>
<assert test="@conformance" id="conformance-required">Relative links require @conformance to indicate MIME type of target file, &check_ancestor;</assert>
<report test="ends-with(@xlink:href, '.doc') and not(@conformance='application/msword')" id="link-conformance-1">Link target ends with '.doc' but @conformance isn't 'application/msword', &check_ancestor;</report>
<report test="ends-with(@xlink:href, '.docx') and not(@conformance='application/msword')" id="link-conformance-2">Link target ends with '.docx' but @conformance isn't 'application/msword', &check_ancestor;</report>
<report test="ends-with(@xlink:href, '.dot') and not(@conformance='application/msword')" id="link-conformance-2a">Link target ends with '.dot' but @conformance isn't 'application/msword', &check_ancestor;</report>
<report test="ends-with(@xlink:href, '.xls') and not(@conformance='application/excel')" id="link-conformance-3">Link target ends with '.xls' but @conformance isn't 'application/excel', &check_ancestor;</report>
<report test="ends-with(@xlink:href, '.xlsx') and not(@conformance='application/excel')" id="link-conformance-4">Link target ends with '.xslx' but @conformance isn't 'application/excel', &check_ancestor;</report>
<report test="ends-with(@xlink:href, '.ps') and not(@conformance='application/postscript')" id="link-conformance-5">Link target ends with '.ps' but @conformance isn't 'application/postscript', &check_ancestor;</report>
<report test="ends-with(@xlink:href, '.pdf') and not(@conformance='application/pdf')" id="link-conformance-6">Link target ends with '.pdf' but @conformance isn't 'application/pdf', &check_ancestor;</report>
<report test="ends-with(@xlink:href, '.ppt') and not(@conformance='application/mspowerpoint')" id="link-conformance-7">Link target ends with '.ppt' but @conformance isn't 'application/mspowerpoint', &check_ancestor;</report>
<report test="ends-with(@xlink:href, '.pptx') and not(@conformance='application/mspowerpoint')" id="link-conformance-8">Link target ends with '.pptx' but @conformance isn't 'application/mspowerpoint', &check_ancestor;</report>
<report test="ends-with(@xlink:href, '.txt') and not(@conformance='text/plain')" id="link-conformance-9">Link target ends with '.txt' but @conformance isn't 'text/plain', &check_ancestor;</report>
<report test="ends-with(@xlink:href, '.xml') and not(@conformance='text/xml')" id="link-conformance-10">Link target ends with '.xml' but @conformance isn't 'text/xml', &check_ancestor;</report>
<report test="ends-with(@xlink:href, '.html') and not(@conformance='text/html')" id="link-conformance-11">Link target ends with '.html' but @conformance isn't 'text/html', &check_ancestor;</report>
<report test="ends-with(@xlink:href, '.htm') and not(@conformance='text/html')" id="link-conformance-12">Link target ends with '.htm' but @conformance isn't 'text/html', &check_ancestor;</report>
<report test="ends-with(@xlink:href, '.css') and not(@conformance='text/css')" id="link-conformance-13">Link target ends with '.css' but @conformance isn't 'text/css', &check_ancestor;</report>
<report test="ends-with(@xlink:href, '.png') and not(@conformance='image/png')" id="link-conformance-14">Link target ends with '.png' but @conformance isn't 'image/png', &check_ancestor;</report>
<report test="ends-with(@xlink:href, '.gif') and not(@conformance='image/gif')" id="link-conformance-15">Link target ends with '.gif' but @conformance isn't 'image/gif', &check_ancestor;</report>
<report test="ends-with(@xlink:href, '.jpg') and not(@conformance='image/jpeg')" id="link-conformance-16">Link target ends with '.jpg' but @conformance isn't 'image/jpeg', &check_ancestor;</report>
<report test="ends-with(@xlink:href, '.jpeg') and not(@conformance='image/jpeg')" id="link-conformance-17">Link target ends with '.jpeg' but @conformance isn't 'image/jpeg', &check_ancestor;</report>
<report test="ends-with(@xlink:href, '.bmp') and not(@conformance='image/bmp')" id="link-conformance-18">Link target ends with '.bmp' but @conformance isn't 'image/bmp', &check_ancestor;</report>
<report test="ends-with(@xlink:href, '.tiff') and not(@conformance='image/tiff')" id="link-conformance-19">Link target ends with '.tiff' but @conformance isn't 'image/tiff', &check_ancestor;</report>
<report test="ends-with(@xlink:href, '.tif') and not(@conformance='image/tiff')" id="link-conformance-20">Link target ends with '.tif' but @conformance isn't 'image/tiff', &check_ancestor;</report>
<report test="ends-with(@xlink:href, '.mpeg') and not(@conformance='video/mpeg')" id="link-conformance-21">Link target ends with '.mpeg' but @conformance isn't 'video/mpeg', &check_ancestor;</report>
<report test="ends-with(@xlink:href, '.mpg') and not(@conformance='video/mpeg')" id="link-conformance-22">Link target ends with '.mpg' but @conformance isn't 'video/mpeg', &check_ancestor;</report>
<report test="ends-with(@xlink:href, '.mp3') and not(@conformance='video/mpeg')" id="link-conformance-23">Link target ends with '.mp3' but @conformance isn't 'video/mpeg', &check_ancestor;</report>
</rule>
<rule context="db:link/@conformance" id="conformance-context">
<assert test="matches(., '^application/msword$') or matches(., '^application/excel$') or matches(., '^application/postscript$') or matches(., '^application/pdf$') or matches(., '^application/mspowerpoint$') or matches(., '^text/plain$') or matches(., '^text/xml$') or matches(., '^text/html$') or matches(., '^text/css$') or matches(., '^image/png$') or matches(., '^image/gif$') or matches(., '^image/jpeg$') or matches(., '^image/bmp$') or matches(., '^image/tiff$') or matches(., '^video/mpeg$')" id="conformance-values"><name/> must have a valid MIME type, &check_ancestor;</assert>
</rule>
</pattern>

<pattern id="extended-link-tests">
<title>Extended link tests</title>
<rule context="db:link[@role='figure'][ancestor::db:book/db:info/db:biblioid[@otherclass='schematronVersion'] ge '2']" id="link-context-2">
<assert test="local-name(&match_linkend;) = ('figure', 'informalfigure')" id="link-target-figure">link elements with @role=figure must point to "figure" or "informalfigure" elements; this points to <value-of select="local-name(&match_linkend;)"/>. See &ancestor_id;.</assert>
</rule>
<rule context="db:link[@role='table'][ancestor::db:book/db:info/db:biblioid[@otherclass='schematronVersion'] ge '2']" id="link-context-3">
<assert test="local-name(&match_linkend;) = 'table'" id="link-target-table">link elements with @role=table must point to "table" elements; this points to <value-of select="local-name(&match_linkend;)"/>. See &ancestor_id;.</assert>
</rule>
<rule context="db:link[@role='bib'][ancestor::db:book/db:info/db:biblioid[@otherclass='schematronVersion'] ge '2']" id="bib-link-context">
<assert test="local-name(&match_linkend;) = 'bibliomixed'" id="link-target-bibliomixed">link elements with @role=bib must point to "bibliomixed" elements; this points to <value-of select="local-name(&match_linkend;)"/>. See &ancestor_id;.</assert>
</rule>
<rule context="db:link[@role='xref'][ancestor::db:book/db:info/db:biblioid[@otherclass='schematronVersion'] ge '2']" id="xref-link-context">
<assert test="(local-name(&match_linkend;) != 'bibliomixed') and (local-name(&match_linkend;) != 'table') and (local-name(&match_linkend;) != 'figure')" id="link-target-xref">link elements with @role=xref must not point to "table", "figure" or "bibliomixed" elements; this points to <value-of select="local-name(&match_linkend;)"/>. See &ancestor_id;.</assert>
</rule>
</pattern>	
<pattern id="extended-link-tests2">
<title>More extended link tests</title>
<rule context="db:link[@linkend][ancestor::db:book/db:info/db:biblioid[@otherclass='schematronVersion'] ge '2']" id="link-context-4">
<assert test="@role" id="link-role-required">If schematronVersion is greater than or equal to 2, then internal links must have @role, &ancestor_id;</assert>
</rule>
</pattern>

<pattern id="olinks">
<title>olinks (linking to other books)</title>
<rule id="olink-context" context="db:olink">
<let name="olink-target-number" value="substring-after(@targetdoc, '-')"/>
        <let name="bookID" value="ancestor::db:book/@xml:id"/>
<assert test="@targetdoc" id="olink-targetdoc">An <name/> element must have @targetdoc, &check_ancestor;</assert>
<assert test="@targetptr" id="olink-targetptr">An <name/> element must have @targetptr, &check_ancestor;</assert>
<assert test="@type" id="olink-type">An <name/> element must have @type, &check_ancestor;</assert>
<assert test="starts-with(@targetdoc, 'b-')" id="olink-targetdoc-id1">An <name/> @targetdoc must start with 'b-', &check_ancestor;</assert>
<assert test="string-length($olink-target-number) eq number('13')" id="olink-targetdoc-id2">An <name/> @targetdoc must consist of 13 digits after the prefix [not <value-of select="string-length($olink-target-number)"/>, as in the current case] (ie the target book XML ISBN (book/@xml:id)), &check_ancestor;</assert>
<assert test="matches($olink-target-number, '^[0-9]+$')" id="olink-targetdoc-id3">The number after the prefix in the olink/@targetdoc must be a 13 digit number (ie the target book XML ISBN (book/@xml:id)), &check_ancestor;</assert>
<assert test="matches(@targetptr, '^[A-Za-z]')" id="olink-targetptr-id">An <name/> @targetptr must be a valid xml ID (ie start with a letter), &check_ancestor;</assert>
        <report test="starts-with(@targetptr, $bookID)" id="olink-link1">The <name/> has @targetptr that starts with the Book ID (@xml:id) so this is an internal link, for which link must be used, &check_ancestor;</report>
        <report test="starts-with(@targetdoc, $bookID)" id="olink-link2">The <name/> has @targetdoc that starts with the Book ID (@xml:id) so this is an internal link, for which link must be used, &check_ancestor;</report>
</rule>
</pattern>

<pattern id="olinks-2">
<title>More constrained olink rules</title>
<rule id="olink-context2" context="db:olink[@type='otherBook'][ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '3']]">
<let name="targetdocID" value="substring-after(@targetdoc, 'b-')"/>
<let name="targetptr" value="substring-after(@targetptr, 'b-')"/>
<let name="targetptrBook" value="substring-before($targetptr, '-')"/>
<assert test="$targetdocID = $targetptrBook" id="olink-targets">The @targetdoc (<value-of select="$targetdocID"/>) must be in the same book as the @targetptr (<value-of select="$targetptrBook"/>), &check_ancestor;</assert>
</rule>
</pattern>

	<!-- checks on bibliographic elements -->
	<pattern id='basic-bibliographic-checks'>
<title>Volume and issue number are normally numeric and should not contain "vol" etc</title>
		<rule context="db:volumenum | db:issuenum" id="vol-iss-context">
&precedingPageNoVariable;
			<assert role='warning' id='volume-issue-numeric' test="translate(., 'IVLMXCivlmxc0123456789&#x2013;&#x0026;\/, .-–', '') = ''">Volume and issue numbers are usually numeric; check "<name/>" element with content ="<value-of select="."/>" within the &ancestor_string;. &pageNoAndChunkPDF;</assert> 
		</rule>
	</pattern>

	<!-- Names -->
	<pattern id='name-checks'>
<title>General name tests</title>
		<rule context="db:firstname/node()[not(self::db:footnote)] | db:surname/node()[not(self::db:footnote)] | db:othername/node()[not(self::db:footnote)] | db:honorific/node()[not(self::db:footnote)] | db:lineage/node()[not(self::db:footnote)]" id="etal-context">
&precedingPageNoVariable;
			<assert test="not(contains(normalize-space(.),'et al'))" id="et-al-present">The text "et al" is not part of a name; it should be PCDATA within the bibliographic item; &check_ancestor; &pageNoAndChunkPDF;</assert>
		</rule>
        <rule context="db:personname" id="personname-context">
&precedingPageNoVariable;
            <report test="db:othername and not(db:firstname)" id="othername-no-firstname">Names with an othername and no firstname are wrong. Probably need firstname[@role=initials] &check_ancestor; &pageNoAndChunkPDF;</report>
            <!--<report test="contains(db:honorific, 'Dr') and ancestor::db:info/parent::db:book" role="warning" id="book-honorific-dr">It is unusual to have a 'Dr' honorific in the book metadata (does it appear on the book title page?), &check_ancestor;</report>-->
            <report test="ancestor::db:info and @role='last-first' and not(ancestor::db:footnote)" id="name-order-info" role="warning">Person name is in info element, but has @role=last-first, which is very unusual. OK? &check_ancestor; &pageNoAndChunkPDF;</report>
        </rule>
	</pattern>

<pattern id="name-checks-2">
<title>Content that should be in lineage</title>
		<rule context="db:firstname/node()[not(self::db:footnote)] | db:surname/node()[not(self::db:footnote)] | db:othername/node()[not(self::db:footnote)] | db:honorific/node()[not(self::db:footnote)]" id="lineage-context">
&precedingPageNoVariable;
			<report test="contains(normalize-space(.),'Jr')" id="jr-present" role="warning">The text "Jr" is not part of a name; it may need to be within a lineage element (check if it needs a @role=comma-before); &check_ancestor; &pageNoAndChunkPDF;</report>
		        <report test="contains(normalize-space(.),' Sr')" id="sr-present" role="warning">The text " Sr" is not part of a name; it may need to be within a lineage element (check if it needs a @role=comma-before); &check_ancestor; &pageNoAndChunkPDF;</report>
		        <report test="contains(normalize-space(.),'II')" id="II-present" role="warning">The text "II" is not part of a name; it may need to be within a lineage element (check if it needs a @role=comma-before); &check_ancestor; &pageNoAndChunkPDF;</report>
		        <report test="contains(normalize-space(.),'III')" id="III-present" role="warning">The text "III" is not part of a name; it may need to be within a lineage element (check if it needs a @role=comma-before); &check_ancestor; &pageNoAndChunkPDF;</report>
		        <report test="contains(normalize-space(.),'IV')" id="IV-present" role="warning">The text "IV" is not part of a name; it may need to be within a lineage element (check if it needs a @role=comma-before); &check_ancestor; &pageNoAndChunkPDF;</report>
		</rule>
</pattern>	

<pattern id="name-checks-3">
<title>Components of names</title>
<rule context="db:surname/node()[not(self::db:footnote)]" id="name-component-context">
&precedingPageNoVariable;
<report test="contains(., '.')" id="surname-with-stop" role="warning">A surname probably shouldn't contain a full stop (<value-of select="."/>), &check_ancestor; &pageNoAndChunkPDF;</report>
</rule>
<rule context="db:firstname[not(@role='initials')]" id="firstname-context">
&precedingPageNoVariable;
<report test="contains(., ' ')" role="warning" id="space-firstname">Element firstname contains a space; is there more than one name in the element? Middle names/initials should use othername+attribute, &check_ancestor; &pageNoAndChunkPDF;</report>
<report test="contains(., '.')" role="error" id="stop-firstname">Element firstname contains a full stop; the full stop should be outside the firstname element, or should this have @role=initials, &check_ancestor; &pageNoAndChunkPDF;</report>
<report test="contains(., ',')" role="error" id="comma-firstname">Element firstname contains a comma; the comma should be outside the firstname element, &check_ancestor; &pageNoAndChunkPDF;</report>
</rule>
        <rule context="db:honorific" id="hon-context">
&precedingPageNoVariable;
<report test="contains(., 'Dirs.') or contains(., 'dirs.') or contains(., 'Dir.') or contains(., 'dir.')" id="honorific-dir" role="warning">The honorific element contains 'Dirs.' (= director(s)?). Should this be in honorific, or better in bibliomisc[@role=description]? &check_ancestor; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

<pattern id="name-checks-3a">
<title>Name components depending on preferred style</title>
<rule context="db:firstname[@role='initials'] | db:othername[@role='middle-initials']" id="name-context-4">
        <!-- myBiblioType: first check if ancestor bibliography has one, then if ancestor chapter does, finally if book does, otherwise assign default value -->
        <let name="myBiblioType" value=" if (ancestor::db:bibliography/db:info/db:biblioid[@otherclass='biblioType']) then (ancestor::db:bibliography/db:info/db:biblioid[@otherclass='biblioType']) else (if (ancestor::db:chapter/db:info/db:biblioid[@otherclass='biblioType']) then (ancestor::db:chapter/db:info/db:biblioid[@otherclass='biblioType']) else (if (ancestor::db:book/db:info/db:biblioid[@otherclass='biblioType']) then (ancestor::db:book/db:info/db:biblioid[@otherclass='biblioType']) else ('initials-with-stops')))"/>
&precedingPageNoVariable;
<assert test="if ($myBiblioType='initials-with-stops') then (ends-with(., '.')) else 1" id="name-initials">[my biblioType=<value-of select="$myBiblioType"/>] Element <name/>[@role=<value-of select="@role"/>] should end with a stop (but there should not be a stop outside the element as the next character either) [OR, should the book or chunk have biblioType=initials-without-stops?], &check_ancestor; &pageNoAndChunkPDF;</assert>
        <report test="if ($myBiblioType='initials-with-stops') then (string-length(.)=1) else 0" role="warning" id="firstname-one-char">[my biblioType=<value-of select="$myBiblioType"/>] The <name/> is only 1 character long. If an initial, it needs to have correct @role, and a full stop within the element, &check_ancestor; &pageNoAndChunkPDF;</report>
        <report test="if ($myBiblioType='initials-with-stops') then (contains(.,'.') and not(@role='initials' or @role='middle-initials')) else 0" role="warning" id="firstname-stop">[my biblioType=<value-of select="$myBiblioType"/>] The <name/> contains a full stop, but does not have appropriate @role, is that correct? &check_ancestor; &pageNoAndChunkPDF;</report>
        <report test="if ($myBiblioType='initials-with-stops') then (ends-with(., '.') and following::text()[1][starts-with(., '.')]) else 0" id="firstname-stop-2">[my biblioType=<value-of select="$myBiblioType"/>] The <name/> ends with a full stop, but following text node starts with one too, which isn't right, &check_ancestor; &pageNoAndChunkPDF;</report>
        <assert test="if ($myBiblioType='initials-without-stops') then (not(ends-with(., '.'))) else 1" id="name-initials-1">[my biblioType=<value-of select="$myBiblioType"/>] Element <name/>[@role=<value-of select="@role"/>] should not end with a stop (but there should not be a stop outside the element as the next character either) [OR, should the book or chunk have biblioType=initials-with-stops?], &check_ancestor; &pageNoAndChunkPDF;</assert>
        <report test="if ($myBiblioType='initials-without-stops') then (string-length(.)=1  and not(@role='initials' or @role='middle-initials')) else 0" role="error" id="firstname-one-char-2">[my biblioType=<value-of select="$myBiblioType"/>] The <name/> is only 1 character long. If an initial, it needs to have correct @role &check_ancestor; &pageNoAndChunkPDF;</report>
        <report test="if ($myBiblioType='initials-without-stops') then (contains(.,'.')) else 0" role="error" id="firstname-stop-4">[my biblioType=<value-of select="$myBiblioType"/>] The <name/> contains a full stop, but this is a book or chunk for which initials in biblio references don't have stops &check_ancestor; &pageNoAndChunkPDF;</report>
        <report test="if ($myBiblioType='initials-without-stops') then (following::text()[1][starts-with(., '.')]) else 0" id="firstname-stop-3">[my biblioType=<value-of select="$myBiblioType"/>] The <name/> has following text node that starts with a stop, but this is a book or chunk for which initials in biblio references don't have stops, so this isn't right, &check_ancestor; &pageNoAndChunkPDF;</report>
</rule>
</pattern>


<pattern id="name-checks-5">
<title>Things that should be in honorific</title>
<rule context="db:firstname | db:surname | db:othername | db:lineage" id="name-context-6">
&precedingPageNoVariable;
<report test="starts-with(., 'Sir ') or starts-with(., 'Lord ') or starts-with(., 'Dr ') or starts-with(., 'Prof.') or starts-with(., 'Prof ') or starts-with(., 'Professor ') or starts-with(., 'Baroness') or starts-with(., 'Rev.')" id="honorific-start" role="warning">Element <name/> starts with a component that may need to be in 'honorific', &check_ancestor; &pageNoAndChunkPDF;</report>
</rule>
</pattern>
<pattern id="name-checks-6">
<title>More things that should be in honorific</title>
<!-- Separated this from the previous pattern in case we need to exclude firstname@role=initials etc -->
<rule context="db:firstname | db:surname | db:othername | db:lineage" id="name-context-7">
&precedingPageNoVariable;
<report id="honorific-end" test="ends-with(., '(Hon)') or ends-with(., 'BA') or ends-with(., 'BDS') or ends-with(.[not(self::db:firstname)], 'B.D.S.') or ends-with(., 'BEd') or ends-with(., 'B.Ed.') or ends-with(., 'BEng') or ends-with(., 'B.Eng.') or ends-with(., 'BSc') or ends-with(., 'B.Sc.') or ends-with(., 'Bart.') or ends-with(., 'Bt') or ends-with(., 'Bt.') or ends-with(., 'CBE') or ends-with(.[not(self::db:firstname)], 'C.B.E.') or ends-with(., 'CH') or ends-with(.[not(self::db:firstname)], 'C.H.') or ends-with(., 'DD') or ends-with(., 'DLitt') or ends-with(., 'D.Litt.') or ends-with(., 'DPhil') or ends-with(., 'D.Phil.') or ends-with(., 'Esq') or ends-with(., 'Esq.') or ends-with(., 'FBA') or ends-with(.[not(self::db:firstname)], 'F.B.A.') or ends-with(., 'FRCP') or ends-with(., 'F.R.C.P.') or ends-with(., 'FRCS') or ends-with(., 'F.R.C.S.') or ends-with(., 'FRS') or ends-with(.[not(self::db:firstname)], 'F.R.S.') or ends-with(., 'Kt') or ends-with(., 'Kt.') or ends-with(., 'LLB') or ends-with(., 'LL.B.') or ends-with(., 'LLD') or ends-with(., 'LL.D.') or ends-with(., 'MA') or ends-with(.[not(self::db:firstname)], 'M.A.') or ends-with(., 'MBA') or ends-with(.[not(self::db:firstname)], 'M.B.A.') or ends-with(., 'MBE') or ends-with(.[not(self::db:firstname)], 'M.B.E.') or ends-with(., 'MD') or ends-with(., 'MEP') or ends-with(.[not(self::db:firstname)], 'M.E.P.') or ends-with(., 'MEd') or ends-with(., 'M.Ed.') or ends-with(., 'MLitt') or ends-with(., 'M.Litt.') or ends-with(., 'MP') or ends-with(.[not(self::db:firstname)], 'M.P.') or ends-with(., 'MRCP') or ends-with(., 'M.R.C.P.') or ends-with(., 'MRCS') or ends-with(., 'M.R.C.S.') or ends-with(., 'MSP') or ends-with(.[not(self::db:firstname)], 'M.S.P.') or ends-with(., 'MSc') or ends-with(., 'M.Sc.') or ends-with(., 'MSci') or ends-with(., 'M.Sci.') or ends-with(., 'OM') or ends-with(., 'O.M.') or ends-with(., 'OSB') or ends-with(.[not(self::db:firstname)], 'O.S.B.') or ends-with(., 'PhD') or ends-with(., 'Ph.D.') or ends-with(., 'QC') or ends-with(.[not(self::db:firstname)], 'Q.C.') or ends-with(., 'SJ')">Element <name/> ends with a component that should be in 'honorific', &check_ancestor; &pageNoAndChunkPDF;</report>
</rule>
</pattern>
<pattern id="firstnames">
<title>Firstnames that are marked as surnames</title>
<let name="firstnames" value="'Aaron', 'Abbie', 'Abby', 'Abdel', 'Abdul', 'Abel', 'Abelard', 'Abie', 'Abigail', 'Abner', 'Adam', 'Adamo', 'Adan', 'Ade', 'Adelbert', 'Adele', 'Adelina', 'Adeline', 'Adolf', 'Adolph', 'Adolphe', 'Adolpho', 'Adolphus', 'Adrian', 'Adriana', 'Adriane', 'Adrianna', 'Adrianne', 'Adriano', 'Adrien', 'Adrienne', 'Agata', 'Agatha', 'Agathe', 'Agnes', 'Agosto', 'Aidan', 'Ailbert', 'Aileen', 'Ailene', 'Aimee', 'Akim', 'Aksel', 'Al', 'Alain', 'Alan', 'Aland', 'Alano', 'Alanson', 'Alard', 'Alaric', 'Alasdair', 'Alastair', 'Alasteir', 'Alaster', 'Alberik', 'Albert', 'Alberto', 'Albie', 'Aldo', 'Aldous', 'Aldric', 'Alec', 'Alejandra', 'Alejandro', 'Alejoa', 'Aleksandr', 'Alessandra', 'Alessandro', 'Alethea', 'Alex', 'Alexandra', 'Alexandre', 'Alexandrina', 'Alexandro', 'Alexandros', 'Alexei', 'Alexio', 'Alexis', 'Alf', 'Alfie', 'Alfons', 'Alfonse', 'Alfonso', 'Alfred', 'Alfreda', 'Alfredo', 'Alfy', 'Algernon', 'Alice', 'Alicia', 'Alick', 'Alisander', 'Alison', 'Alistair', 'Alister', 'Alix', 'Allister', 'Allistir', 'Allyn', 'Aloin', 'Alon', 'Alonso', 'Alonzo', 'Aloysius', 'Alphonse', 'Alphonso', 'Alric', 'Aluin', 'Aluino', 'Alva', 'Alvan', 'Alvie', 'Alvin', 'Alvis', 'Alvy', 'Alwin', 'Alwyn', 'Alyosha', 'Amalia', 'Amalie', 'Amanda', 'Amble', 'Ambros', 'Ambrose', 'Ambrosi', 'Ambrosio', 'Ambrosius', 'Amby', 'Amelia', 'Amelie', 'Amerigo', 'Ana', 'Anabella', 'Anabelle', 'Analiese', 'Analise', 'Anastasia', 'Anastasie', 'Anastassia', 'Anatol', 'Anatole', 'Anatollo', 'Andre', 'Andrea', 'Andreas', 'Andrej', 'Andres', 'Andrew', 'Andrey', 'Andris', 'Andros', 'Andrus', 'Andy', 'Ange', 'Angel', 'Angela', 'Angele', 'Angeli', 'Angelica', 'Angelico', 'Angelika', 'Angelina', 'Angeline', 'Angelique', 'Angelo', 'Angie', 'Angus', 'Anja', 'Ann-Marie', 'Anna', 'Anna-Maria', 'Annabela', 'Annabell', 'Annabella', 'Annabelle', 'Annaliese', 'Annalise', 'Annamaria', 'Annamarie', 'Anne', 'Anne-Marie', 'Annette', 'Anselm', 'Anthony', 'Antony', 'Antoine', 'Antoinette', 'Antone', 'Antoni', 'Antonia', 'Antonin', 'Antonino', 'Antonio', 'Antonius', 'Anya', 'Arabelle', 'Archibald', 'Archibaldo', 'Archibold', 'Archie', 'Archy', 'Arel', 'Ari', 'Arie', 'Ariel', 'Arin', 'Ario', 'Aristotle', 'Arlan', 'Arlen', 'Arley', 'Arlin', 'Arman', 'Armand', 'Armando', 'Armin', 'Arnaldo', 'Arne', 'Arney', 'Arni', 'Arnie', 'Arnoldo', 'Arnuad', 'Arny', 'Aron', 'Arri', 'Arron', 'Art', 'Artair', 'Arte', 'Artemas', 'Artemis', 'Artemus', 'Arther', 'Arthur', 'Artie', 'Artur', 'Arturo', 'Artus', 'Arty', 'Arv', 'Arvie', 'Arvin', 'Arvy', 'Asa', 'Auberon', 'Aubert', 'Aubrey', 'Audrey', 'Augie', 'August', 'Augustin', 'Augusto', 'Augustus', 'Barbara', 'Barbra', 'Barnabas', 'Barney', 'Barnie', 'Barny', 'Bart', 'Bartholemy', 'Bartholomeo', 'Bartholomeus', 'Bartolemo', 'Bartolomeo', 'Bartram', 'Barty', 'Basil', 'Basile', 'Basilio', 'Basilius', 'Beatrice', 'Beatrix', 'Beatriz', 'Beau', 'Ben', 'Benedetto', 'Benedick', 'Benedict', 'Benedicto', 'Benedikt', 'Bengt', 'Beniamino', 'Benito', 'Benjamen', 'Benji', 'Benjie', 'Benjy', 'Bennie', 'Benny', 'Benoit', 'Benyamin', 'Bernadette', 'Bernadina', 'Bernard', 'Bernardo', 'Bernhard', 'Bernie', 'Bert', 'Berti', 'Bertie', 'Bertram', 'Bertrando', 'Berty', 'Beryl', 'Betsy', 'Bev', 'Bill', 'Billie', 'Billy', 'Bing', 'Birgit', 'Biron', 'Bjorn', 'Bob', 'Bobbie', 'Bobby', 'Boris', 'Brad', 'Brian', 'Briano', 'Brigid', 'Brigit', 'Brigitta', 'Brigitte', 'Brion', 'Brit', 'Britney', 'Britt', 'Broderic', 'Broderick', 'Bryan', 'Bryanty', 'Bryn', 'Bryon', 'Bud', 'Buddie', 'Buddy', 'Burnaby', 'Butch', 'Byran', 'Byrann', 'Byrle', 'Byrom', 'Byron', 'Cad', 'Caddric', 'Caesar', 'Caitlin', 'Cal', 'Caleb', 'Camilla', 'Camille', 'Cammy', 'Candice', 'Caren', 'Carl', 'Carlo', 'Carlos', 'Carly', 'Carolina', 'Caroline', 'Carolus', 'Carrol', 'Cary', 'Caryl', 'Casar', 'Caspar', 'Casper', 'Cassandra', 'Cassie', 'Cassius', 'Catarina', 'Caterina', 'Catherine', 'Catriona', 'Cecelia', 'Cecil', 'Cecilia', 'Cecilio', 'Cecilius', 'Ced', 'Cedric', 'Celeste', 'Celestina', 'Celestine', 'Cesar', 'Cesare', 'Cesaro', 'Chaim', 'Chan', 'Chantal', 'Chantalle', 'Chariot', 'Charleen', 'Charlene', 'Charley', 'Charlie', 'Charline', 'Charlotta', 'Charlotte', 'Charmaine', 'Chas', 'Che', 'Chet', 'Chico', 'Chip', 'Chloe', 'Chris', 'Chrisse', 'Chrissie', 'Chrissy', 'Christiana', 'Christiane', 'Christiano', 'Christina', 'Christine', 'Christoffer', 'Christoforo', 'Christoper', 'Christoph', 'Christophe', 'Christopher', 'Christophorus', 'Christos', 'Christy', 'Chrisy', 'Chuck', 'Clair', 'Claire', 'Clara', 'Clarance', 'Clare', 'Clarence', 'Clarissa', 'Claudia', 'Claudian', 'Claudianus', 'Claudio', 'Claudius', 'Claus', 'Clem', 'Clement', 'Clemente', 'Clementina', 'Clementine', 'Clementius', 'Clemmie', 'Clemmy', 'Cleon', 'Clerc', 'Cletis', 'Cletus', 'Cleve', 'Clevey', 'Clevie', 'Cliff', 'Clim', 'Clint', 'Coleen', 'Colene', 'Colet', 'Colette', 'Colin', 'Colleen', 'Collette', 'Conan', 'Connie', 'Constantin', 'Cordelia', 'Corey', 'Cori', 'Corinna', 'Corinne', 'Cornelia', 'Cornelius', 'Cosimo', 'Cosme', 'Cosmo', 'Cozmo', 'Cris', 'Cristian', 'Cristiano', 'Cristina', 'Cristine', 'Cristobal', 'Cynthia', 'Cyril', 'Cyrill', 'Cyrille', 'Cyrillus', 'Cyrus', 'Dagmar', 'Dallas', 'Damian', 'Damiano', 'Damien', 'Damon', 'Dan', 'Dana', 'Dane', 'Dani', 'Danie', 'Daniela', 'Daniella', 'Dannel', 'Dannie', 'Danny', 'Dante', 'Danya', 'Daphne', 'Daren', 'Darill', 'Darin', 'Dario', 'Darius', 'Daron', 'Darrel', 'Darrell', 'Darren', 'Darrick', 'Darrin', 'Darryl', 'Daryl', 'Daryle', 'Dave', 'David', 'Davide', 'Deanna', 'Deanne', 'Debora', 'Deborah', 'Debra', 'Decca', 'Deck', 'Deidre', 'Deirdre', 'Del', 'Delainey', 'Delaney', 'Delano', 'Delbert', 'Delila', 'Delilah', 'Dell', 'Delmar', 'Delmer', 'Delmor', 'Delmore', 'Demetre', 'Demetri', 'Demetris', 'Demetrius', 'Den', 'Dene', 'Denis', 'Dennis', 'Denys', 'Derek', 'Derick', 'Dermot', 'Derrek', 'Derrick', 'Derrik', 'Diana', 'Diane', 'Diarmid', 'Dick', 'Dickie', 'Dicky', 'Dido', 'Diego', 'Dierdre', 'Dieter', 'Dimitri', 'Dimitry', 'Dino', 'Dion', 'Dionisio', 'Dionysus', 'Dirk', 'Dmitri', 'Dolores', 'Dolph', 'Dom', 'Domenic', 'Domenico', 'Domingo', 'Dominic', 'Dominick', 'Dominik', 'Dominique', 'Don', 'Donal', 'Donall', 'Donalt', 'Donaugh', 'Donna', 'Donnie', 'Donny', 'Doreen', 'Dorian', 'Dorie', 'Dorothea', 'Dorothee', 'Dorothy', 'Doug', 'Dougie', 'Dougy', 'Duane', 'Dugald', 'Dwain', 'Dwayne', 'Dwight', 'Eadmund', 'Eamon', 'Ebeneser', 'Ebenezer', 'Eberhard', 'Eberto', 'Ed', 'Edan', 'Edd', 'Eddie', 'Eddy', 'Edgar', 'Edgard', 'Edgardo', 'Edith', 'Edithe', 'Edlin', 'Edmon', 'Edmund', 'Edna', 'Edouard', 'Edsel', 'Eduard', 'Eduardo', 'Eduino', 'Edvard', 'Edward', 'Edwin', 'Edwina', 'Efrem', 'Efren', 'Eileen', 'Ekaterina', 'El', 'Elaine', 'Elbert', 'Eleanor', 'Eleanora', 'Eleanore', 'Elenore', 'Eleonora', 'Eleonore', 'Eli', 'Elia', 'Elias', 'Elihu', 'Elijah', 'Eliot', 'Elisa', 'Elisabeth', 'Elisha', 'Elizabet', 'Elizabeth', 'Elka', 'Elke', 'Ella', 'Elmer', 'Elmo', 'Elroy', 'Elsbeth', 'Elspeth', 'Elvera', 'Elvin', 'Elvis', 'Elvyn', 'Elwin', 'Elwood', 'Elwyn', 'Ely', 'Em', 'Emanuel', 'Emanuele', 'Emelen', 'Emerson', 'Emery', 'Emile', 'Emilia', 'Emilie', 'Emiline', 'Emilio', 'Emily', 'Emlen', 'Emlyn', 'Emma', 'Emmanuel', 'Emmeline', 'Emmy', 'Engelbert', 'Englebert', 'Enoch', 'Enos', 'Enrico', 'Enrique', 'Ephraim', 'Ephrayim', 'Ephrem', 'Erhard', 'Erhart', 'Eric', 'Erica', 'Erich', 'Erick', 'Erie', 'Erik', 'Erika', 'Erin', 'Ermanno', 'Ermin', 'Ermina', 'Ernest', 'Ernesto', 'Ernestus', 'Ernie', 'Ernst', 'Erny', 'Errick', 'Errol', 'Erroll', 'Esdras', 'Esme', 'Esmeralda', 'Esra', 'Esteban', 'Estele', 'Estella', 'Estelle', 'Ester', 'Esther', 'Etan', 'Ethan', 'Ethe', 'Ethel', 'Ethelbert', 'Ethelred', 'Etienne', 'Eugenia', 'Eugenie', 'Eugenio', 'Eugenius', 'Eustace', 'Eva', 'Eve', 'Evan', 'Evelin', 'Eveline', 'Evelyn', 'Evin', 'Evyn', 'Ewan', 'Ezekiel', 'Ezequiel', 'Eziechiele', 'Ezra', 'Ezri', 'Fabe', 'Faber', 'Fabian', 'Fabiano', 'Fabien', 'Fabio', 'Federico', 'Felicia', 'Felicio', 'Felicity', 'Felike', 'Feliks', 'Felipe', 'Felix', 'Felizio', 'Feodor', 'Ferd', 'Ferdie', 'Ferdinand', 'Ferdinanda', 'Ferdinande', 'Ferdy', 'Fergus', 'Fernanda', 'Fernande', 'Fernando', 'Fidel', 'Fidelio', 'Filip', 'Filippo', 'Fin', 'Fiona', 'Fionnula', 'Florence', 'Florian', 'Flory', 'Fons', 'Fonsie', 'Fonz', 'Fonzie', 'Fran', 'Francene', 'Frances', 'Francesca', 'Francesco', 'Franchot', 'Francine', 'Francis', 'Francisca', 'Francisco', 'Franciska', 'Franciskus', 'Francklin', 'Francklyn', 'Francois', 'Francoise', 'Frank', 'Frankie', 'Frannie', 'Franny', 'Frans', 'Fransisco', 'Franz', 'Fred', 'Freda', 'Freddie', 'Freddy', 'Fredek', 'Frederic', 'Frederich', 'Frederick', 'Frederico', 'Frederigo', 'Frederik', 'Fredric', 'Fredrick', 'Freida', 'Frieda', 'Friedrich', 'Friedrick', 'Fritz', 'Fulton', 'Gabbie', 'Gabby', 'Gabi', 'Gabie', 'Gabriel', 'Gabriela', 'Gabriele', 'Gabriella', 'Gabrielle', 'Gabriello', 'Gaby', 'Gael', 'Gail', 'Gaile', 'Gareth', 'Garreth', 'Garry', 'Garth', 'Gary', 'Gaspar', 'Gaspard', 'Gasparo', 'Gasper', 'Gaultiero', 'Gauthier', 'Gav', 'Gavan', 'Gaven', 'Gavin', 'Gawain', 'Gayle', 'Gene', 'Genevieve', 'Geoff', 'Geoffrey', 'Geoffry', 'Georas', 'Geordie', 'Georg', 'George', 'Georges', 'Georgette', 'Georgi', 'Georgie', 'Georgina', 'Georgy', 'Gerald', 'Geraldine', 'Gerard', 'Gerardo', 'Gerek', 'Gerhard', 'Gerhardt', 'Geri', 'Gerick', 'Gerik', 'Germain', 'Germaine', 'Germayne', 'Gerome', 'Gerrard', 'Gerri', 'Gerrie', 'Gerry', 'Gertrude', 'Gery', 'Gherardo', 'Giacobo', 'Giacomo', 'Giacopo', 'Gian', 'Gianni', 'Giavani', 'Gideon', 'Gilles', 'Gillian', 'Ginger', 'Gino', 'Giordano', 'Giorgio', 'Giovanna', 'Giovanni', 'Giraldo', 'Giraud', 'Gisela', 'Giselbert', 'Giulia', 'Giulietta', 'Giulio', 'Giuseppe', 'Giustino', 'Giusto', 'Gladys', 'Glen', 'Glenda', 'Gloria', 'Glyn', 'Glynis', 'Gonzalo', 'Goober', 'Goran', 'Goraud', 'Gordan', 'Gorden', 'Gordie', 'Gordon', 'Gothart', 'Gottfried', 'Grace', 'Gradeigh', 'Gradey', 'Graehme', 'Graeme', 'Greg', 'Gregg', 'Gregoire', 'Gregoor', 'Gregor', 'Gregorio', 'Gregorius', 'Greta', 'Gretchen', 'Gualterio', 'Guglielmo', 'Guido', 'Guilbert', 'Guillaume', 'Guillermo', 'Gunar', 'Guntar', 'Gunter', 'Gunther', 'Gus', 'Guss', 'Gustaf', 'Gustav', 'Gustave', 'Gustavo', 'Gustavus', 'Guy', 'Gwendolen', 'Gwendolin', 'Gwendolyn', 'Gweneth', 'Gwyneth', 'Hadlee', 'Hadrian', 'Hakeem', 'Hakim', 'Hal', 'Hamish', 'Hammad', 'Hanan', 'Hank', 'Hannah', 'Hans', 'Hansiain', 'Harlan', 'Harland', 'Harlen', 'Harriet', 'Harry', 'Hasheem', 'Hashim', 'Hayyim', 'Hector', 'Heidi', 'Heindrick', 'Heinrick', 'Heinrik', 'Helen', 'Helena', 'Helene', 'Hendrick', 'Hendrik', 'Henri', 'Henrietta', 'Henriette', 'Henrik', 'Herb', 'Herbert', 'Herbie', 'Herby', 'Hercule', 'Hercules', 'Herculie', 'Heriberto', 'Hermina', 'Hermine', 'Hermione', 'Hermy', 'Hernando', 'Hester', 'Hesther', 'Hilario', 'Hilarius', 'Hilda', 'Hilde', 'Hiram', 'Holly', 'Homere', 'Homerus', 'Horace', 'Horacio', 'Horatio', 'Horatius', 'Horst', 'Hoyt', 'Hube', 'Hubert', 'Huberto', 'Hubey', 'Hubie', 'Huey', 'Hugh', 'Hughie', 'Hugibert', 'Hugo', 'Hugues', 'Humbert', 'Humberto', 'Humfrey', 'Humfrid', 'Humfried', 'Humphrey', 'Hunfredo', 'Iago', 'Iain', 'Ian', 'Ida', 'Iggie', 'Iggy', 'Ignace', 'Ignacio', 'Ignacius', 'Ignatius', 'Ignaz', 'Ignazio', 'Igor', 'Ike', 'Ilsa', 'Ilse', 'Imelda', 'Immanuel', 'Imogen', 'Ines', 'Inga', 'Ingamar', 'Ingar', 'Inge', 'Ingelbert', 'Ingemar', 'Inger', 'Inglebert', 'Ingmar', 'Ingra', 'Ingrid', 'Ingrim', 'Inigo', 'Inness', 'Innis', 'Iorgo', 'Iorgos', 'Iosep', 'Ira', 'Irena', 'Irene', 'Irina', 'Iris', 'Isaac', 'Isaak', 'Isabel', 'Isabella', 'Isabelle', 'Isac', 'Isacco', 'Isador', 'Isadora', 'Isadore', 'Isaiah', 'Isak', 'Isiahi', 'Isidor', 'Isidora', 'Isidore', 'Isidoro', 'Isidro', 'Isobel', 'Issiah', 'Itch', 'Ivan', 'Ivar', 'Ive', 'Iver', 'Ives', 'Ivonne', 'Ivor', 'Izaak', 'Izak', 'Izzy', 'Jabez', 'Jacinta', 'Jack', 'Jackie', 'Jacky', 'Jaclyn', 'Jacob', 'Jacobo', 'Jacqueline', 'Jacquelyn', 'Jacques', 'Jae', 'Jaime', 'Jaimie', 'Jake', 'Jakie', 'Jakob', 'Jamaal', 'Jamal', 'Jamey', 'Jamie', 'Jamil', 'Jamill', 'Jammal', 'Jan', 'Jane', 'Janek', 'Janella', 'Janelle', 'Janet', 'Janice', 'Janine', 'Janis', 'Janith', 'Janka', 'Janna', 'Jannel', 'Jannelle', 'Janos', 'Jany', 'Jaquelin', 'Jaquelyn', 'Jaquenetta', 'Jarad', 'Jared', 'Jarid', 'Jarrad', 'Jarred', 'Jasmin', 'Jasmina', 'Jasmine', 'Jason', 'Jasun', 'Javier', 'Jayme', 'Jaymee', 'Jaymie', 'Jayne', 'Jaynell', 'Jayson', 'Jazmin', 'Jean', 'Jeana', 'Jeane', 'Jeanelle', 'Jeanette', 'Jeanie', 'Jeanine', 'Jeanna', 'Jeanne', 'Jeannette', 'Jeannie', 'Jeannine', 'Jecho', 'Jed', 'Jedd', 'Jeddy', 'Jedediah', 'Jedidiah', 'Jeff', 'Jemima', 'Jemimah', 'Jemmie', 'Jemmy', 'Jen', 'Jena', 'Jenda', 'Jenefer', 'Jenelle', 'Jeni', 'Jenica', 'Jeniece', 'Jenifer', 'Jeniffer', 'Jenilee', 'Jenine', 'Jenn', 'Jenna', 'Jennee', 'Jennette', 'Jenni', 'Jennica', 'Jennie', 'Jennifer', 'Jennilee', 'Jennine', 'Jenny', 'Jens', 'Jephthah', 'Jerad', 'Jerald', 'Jeralee', 'Jeramey', 'Jeramie', 'Jeremiah', 'Jeremias', 'Jeremie', 'Jeremy', 'Jeri', 'Jermain', 'Jermaine', 'Jermayne', 'Jerome', 'Jeromy', 'Jerri', 'Jerrie', 'Jerrilee', 'Jerrilyn', 'Jerrome', 'Jerry', 'Jerrylee', 'Jess', 'Jessa', 'Jessalin', 'Jessalyn', 'Jessamine', 'Jessamyn', 'Jesse', 'Jessee', 'Jesselyn', 'Jessey', 'Jessi', 'Jessica', 'Jessie', 'Jessika', 'Jessy', 'Jesus', 'Jeth', 'Jethro', 'Jill', 'Jillana', 'Jillane', 'Jillayne', 'Jilleen', 'Jillene', 'Jilli', 'Jillian', 'Jillie', 'Jilly', 'Jim', 'Jimmie', 'Jimmy', 'Jinny', 'Jo', 'Jo Ann', 'Jo-Ann', 'Jo-Anne', 'Joachim', 'Joan', 'Joana', 'Joane', 'Joanie', 'Joann', 'Joanna', 'Joanne', 'Joannes', 'Joaquin', 'Job', 'Jobey', 'Jobi', 'Jobie', 'Jobina', 'Joby', 'Jobye', 'Jobyna', 'Jocelin', 'Joceline', 'Jocelyn', 'Jocelyne', 'Jock', 'Jocko', 'Jodee', 'Jodi', 'Jodie', 'Jody', 'Joe', 'Joeann', 'Joel', 'Joela', 'Joelie', 'Joell', 'Joella', 'Joelle', 'Joellen', 'Joelly', 'Joellyn', 'Joelynn', 'Joete', 'Joey', 'Johan', 'Johann', 'Johanna', 'Johannah', 'Johannes', 'John', 'Johna', 'Johnath', 'Johnathan', 'Johnathon', 'Johnette', 'Johnna', 'Johnnie', 'Johnny', 'Johny', 'Joice', 'Jojo', 'Jolee', 'Joleen', 'Jolene', 'Joletta', 'Joli', 'Jolie', 'Joline', 'Joly', 'Jolyn', 'Jolynn', 'Jon', 'Jonah', 'Jonas', 'Jonathan', 'Jonathon', 'Jone', 'Jonell', 'Joni', 'Jonie', 'Jonis', 'Jordain', 'Jordan', 'Jordana', 'Jordanna', 'Jordon', 'Jorey', 'Jorgan', 'Jorge', 'Jori', 'Jorie', 'Jorrie', 'Jorry', 'Jory', 'Joscelin', 'Jose', 'Josee', 'Josefa', 'Josefina', 'Joseito', 'Joseph', 'Josepha', 'Josephina', 'Josephine', 'Josey', 'Josh', 'Joshia', 'Joshua', 'Joshuah', 'Josi', 'Josiah', 'Josias', 'Josie', 'Josselyn', 'Josy', 'Jourdain', 'Jourdan', 'Joy', 'Joya', 'Joyan', 'Joyann', 'Joycelin', 'Joye', 'Jozef', 'Jsandye', 'Juan', 'Juana', 'Juanita', 'Jud', 'Judah', 'Judas', 'Jude', 'Judi', 'Judie', 'Judith', 'Juditha', 'Judon', 'Judy', 'Judye', 'Juieta', 'Jule', 'Julee', 'Jules', 'Juli', 'Julia', 'Julian', 'Juliana', 'Juliane', 'Juliann', 'Julianna', 'Julianne', 'Julie', 'Julienne', 'Juliet', 'Julieta', 'Julietta', 'Juliette', 'Julina', 'Juline', 'Julio', 'Julissa', 'Julita', 'Julius', 'June', 'Junette', 'Junia', 'Junie', 'Junina', 'Justen', 'Justin', 'Justina', 'Justine', 'Justinian', 'Justinn', 'Justino', 'Justis', 'Justus', 'Jyoti', 'Kacey', 'Kacie', 'Kacy', 'Kaela', 'Kahaleel', 'Kahlil', 'Kai', 'Kaia', 'Kaitlin', 'Kaitlyn', 'Kaitlynn', 'Kaja', 'Kakalina', 'Kala', 'Kale', 'Kaleb', 'Kaleena', 'Kali', 'Kalie', 'Kalil', 'Kalila', 'Kalina', 'Kalinda', 'Kalindi', 'Kalle', 'Kalli', 'Kally', 'Kalvin', 'Kameko', 'Kamila', 'Kamilah', 'Kamillah', 'Kandace', 'Kandy', 'Kania', 'Kanya', 'Kara', 'Kara-Lynn', 'Karalee', 'Karalynn', 'Kare', 'Karee', 'Kareem', 'Karel', 'Karen', 'Karena', 'Kari', 'Karia', 'Karie', 'Karil', 'Karilynn', 'Karin', 'Karina', 'Karine', 'Kariotta', 'Karisa', 'Karissa', 'Karita', 'Karl', 'Karla', 'Karleen', 'Karlen', 'Karlene', 'Karlens', 'Karlie', 'Karlik', 'Karlis', 'Karlotta', 'Karlotte', 'Karly', 'Karlyn', 'Karmen', 'Karna', 'Karney', 'Karol', 'Karola', 'Karole', 'Karolina', 'Karoline', 'Karoly', 'Karon', 'Karrah', 'Karrie', 'Karry', 'Kary', 'Karyl', 'Karylin', 'Karyn', 'Kasey', 'Kaspar', 'Kasper', 'Kass', 'Kassandra', 'Kassey', 'Kassi', 'Kassia', 'Kassie', 'Kat', 'Kata', 'Katalin', 'Kate', 'Katee', 'Katerina', 'Katerine', 'Katey', 'Kath', 'Katha', 'Katharina', 'Katharine', 'Katharyn', 'Kathe', 'Katherina', 'Katherine', 'Katheryn', 'Kathi', 'Kathie', 'Kathleen', 'Kathlin', 'Kathrine', 'Kathryn', 'Kathryne', 'Kathy', 'Kathye', 'Kati', 'Katie', 'Katina', 'Katine', 'Katinka', 'Katleen', 'Katlin', 'Katrina', 'Katrine', 'Katrinka', 'Katti', 'Kattie', 'Katuscha', 'Katusha', 'Katy', 'Katya', 'Kaycee', 'Kayla', 'Kayle', 'Kaylee', 'Kayley', 'Kaylil', 'Kaylyn', 'Kayne', 'Keefe', 'Keefer', 'Kelcey', 'Kelci', 'Kelcie', 'Kelcy', 'Kelila', 'Kellsie', 'Kellyann', 'Kelsey', 'Kelsi', 'Kelsy', 'Ken', 'Kenneth', 'Kennie', 'Kennith', 'Kenton', 'Keri', 'Keriann', 'Kerianne', 'Kerk', 'Kermie', 'Kermit', 'Kermy', 'Kerri', 'Kerrie', 'Kerrin', 'Kerstin', 'Kerwin', 'Kerwinn', 'Kesley', 'Keslie', 'Kessia', 'Kessiah', 'Ketti', 'Kettie', 'Ketty', 'Kev', 'Kevan', 'Keven', 'Kevin', 'Kevina', 'Kevon', 'Kevyn', 'Khalil', 'Kiersten', 'Kikelia', 'Kile', 'Kiley', 'Kirstin', 'Kirstyn', 'Kit', 'Kitti', 'Kittie', 'Kitty', 'Kizzee', 'Kizzie', 'Klara', 'Klarika', 'Klarrisa', 'Klaus', 'Klemens', 'Klement', 'Kleon', 'Kliment', 'Koenraad', 'Konrad', 'Konstance', 'Konstantin', 'Konstantine', 'Konstanze', 'Koo', 'Kora', 'Koral', 'Koralle', 'Kordula', 'Kore', 'Korella', 'Koren', 'Koressa', 'Korey', 'Kori', 'Korie', 'Korney', 'Korrie', 'Korry', 'Kort', 'Kory', 'Kris', 'Krisha', 'Krishna', 'Krishnah', 'Krispin', 'Krissie', 'Krissy', 'Krista', 'Kristal', 'Kristan', 'Kriste', 'Kristel', 'Kristen', 'Kristi', 'Kristian', 'Kristien', 'Kristin', 'Kristina', 'Kristine', 'Kristo', 'Kristofer', 'Kristoffer', 'Kristofor', 'Kristoforo', 'Kristopher', 'Kristos', 'Kristy', 'Kristyn', 'Krysta', 'Krystal', 'Krystalle', 'Krystle', 'Krystyna', 'Kurt', 'Ky', 'Kyla', 'Kyle', 'Kylen', 'Kylie', 'Kylila', 'Kylynn', 'Kym', 'Kynthia', 'Kyrstin', 'La Verne', 'Lacee', 'Ladonna', 'Laetitia', 'Laina', 'Lainey', 'Lalo', 'Lana', 'Lanae', 'Lance', 'Lancelot', 'Lanette', 'Laney', 'Lani', 'Lanie', 'Lanita', 'Lanna', 'Lanni', 'Lannie', 'Lanny', 'Lara', 'Laraine', 'Lari', 'Larina', 'Larine', 'Larisa', 'Larissa', 'Larry', 'Lars', 'Laryssa', 'Latashia', 'Latia', 'Latisha', 'Latrena', 'Latrina', 'Laughton', 'Launce', 'Laura', 'Lauraine', 'Laural', 'Lauralee', 'Laure', 'Lauree', 'Laureen', 'Laurel', 'Laurella', 'Lauren', 'Laurena', 'Laurene', 'Laurens', 'Laurent', 'Lauretta', 'Laurette', 'Lauri', 'Laurianne', 'Laurice', 'Laurie', 'Lauritz', 'Lauryn', 'Lavena', 'Laverna', 'Laverne', 'Lavina', 'Lavinia', 'Lavinie', 'Lay', 'Layla', 'Layne', 'Leah', 'Leandra', 'Leann', 'Leanna', 'Leanor', 'Leanora', 'Leda', 'Leeann', 'Leeanne', 'Leela', 'Leelah', 'Leeland', 'Leena', 'Leesa', 'Leese', 'Lefty', 'Legra', 'Leia', 'Leif', 'Leila', 'Leilah', 'Leisha', 'Lek', 'Lela', 'Lelah', 'Leland', 'Lelia', 'Lem', 'Lemar', 'Lemmie', 'Lemmy', 'Lemuel', 'Lena', 'Lenard', 'Lenci', 'Lenee', 'Lenette', 'Lenka', 'Lenna', 'Lennie', 'Lenora', 'Lenore', 'Leo', 'Leodora', 'Leoine', 'Leola', 'Leoline', 'Leon', 'Leona', 'Leonanie', 'Leonardo', 'Leonelle', 'Leonid', 'Leonidas', 'Leonie', 'Leonora', 'Leonore', 'Leontine', 'Leontyne', 'Leopold', 'Leora', 'Les', 'Leshia', 'Leticia', 'Letisha', 'Letitia', 'Letizia', 'Letta', 'Letti', 'Lettie', 'Letty', 'Leupold', 'Lev', 'Lew', 'Lewie', 'Lexi', 'Lexie', 'Lexine', 'Lexis', 'Lexy', 'Leyla', 'Lezley', 'Lezlie', 'Lia', 'Liam', 'Lian', 'Liana', 'Liane', 'Lianna', 'Lianne', 'Lib', 'Libbey', 'Libbi', 'Libbie', 'Libby', 'Licha', 'Lida', 'Lidia', 'Lief', 'Liesa', 'Lil', 'Lila', 'Lilah', 'Lilas', 'Lilia', 'Lilian', 'Liliane', 'Lilias', 'Lilith', 'Lilla', 'Lilli', 'Lillian', 'Lillis', 'Lilllie', 'Lilly', 'Lily', 'Lilyan', 'Lina', 'Linda', 'Lindi', 'Lindie', 'Lindy', 'Linea', 'Linell', 'Linet', 'Linette', 'Link', 'Linn', 'Linnea', 'Linnell', 'Linnet', 'Linnie', 'Linoel', 'Linus', 'Linzy', 'Lionel', 'Lionello', 'Lira', 'Lisa', 'Lisabeth', 'Lisbeth', 'Lise', 'Lisetta', 'Lisette', 'Lisha', 'Lishe', 'Lisle', 'Lissa', 'Lissi', 'Lissie', 'Lissy', 'Lita', 'Liuka', 'Liv', 'Liva', 'Livia', 'Livvie', 'Livvy', 'Livy', 'Liz', 'Liza', 'Lizabeth', 'Lizbeth', 'Lizette', 'Lizzie', 'Lizzy', 'Lodovico', 'Loella', 'Lois', 'Loise', 'Lola', 'Loleta', 'Lolita', 'Lolly', 'Lon', 'Lona', 'Lonee', 'Loni', 'Lonna', 'Lonnard', 'Lonni', 'Lonnie', 'Lonny', 'Lora', 'Lorain', 'Loraine', 'Loralee', 'Loralie', 'Loralyn', 'Lorant', 'Loree', 'Loreen', 'Lorelei', 'Lorelle', 'Loren', 'Lorena', 'Lorene', 'Lorens', 'Lorenza', 'Lorenzo', 'Loretta', 'Lorette', 'Lori', 'Loria', 'Lorianna', 'Lorianne', 'Lorie', 'Lorilee', 'Lorilyn', 'Lorin', 'Lorinda', 'Lorine', 'Lorita', 'Lorna', 'Lorne', 'Lorraine', 'Lorrayne', 'Lorri', 'Lorrie', 'Lorrin', 'Lorry', 'Lory', 'Lothaire', 'Lothario', 'Lotta', 'Lotte', 'Lotti', 'Lottie', 'Lotty', 'Lou', 'Louella', 'Louie', 'Louisa', 'Louise', 'Louisette', 'Loutitia', 'Lu', 'Luca', 'Lucais', 'Luce', 'Lucho', 'Luci', 'Lucia', 'Lucian', 'Luciana', 'Luciano', 'Lucias', 'Lucie', 'Lucien', 'Lucienne', 'Lucila', 'Lucilia', 'Lucille', 'Lucina', 'Lucinda', 'Lucine', 'Lucio', 'Lucita', 'Lucius', 'Lucky', 'Lucretia', 'Lucy', 'Ludovico', 'Ludovika', 'Ludvig', 'Ludwig', 'Luella', 'Luelle', 'Luigi', 'Luis', 'Luisa', 'Luise', 'Lukas', 'Luke', 'Lula', 'Lulita', 'Lulu', 'Lura', 'Lurette', 'Lurleen', 'Lurlene', 'Lurline', 'Lusa', 'Lutero', 'Luther', 'Luz', 'Ly', 'Lyda', 'Lydia', 'Lydie', 'Lydon', 'Lyell', 'Lyle', 'Lyman', 'Lyn', 'Lynda', 'Lynde', 'Lyndel', 'Lyndell', 'Lyndsay', 'Lyndsey', 'Lyndsie', 'Lyndy', 'Lynea', 'Lynelle', 'Lynett', 'Lynette', 'Lynn', 'Lynna', 'Lynne', 'Lynnett', 'Lynnette', 'Lynsey', 'Lyssa', 'Mab', 'Mabel', 'Mabelle', 'Mable', 'Mac', 'Madalena', 'Madalyn', 'Maddalena', 'Maddi', 'Maddie', 'Maddy', 'Madel', 'Madelaine', 'Madeleine', 'Madelena', 'Madelene', 'Madelin', 'Madelina', 'Madeline', 'Madella', 'Madelle', 'Madelon', 'Madelyn', 'Madonna', 'Mae', 'Maegan', 'Mag', 'Magda', 'Magdaia', 'Magdalen', 'Magdalena', 'Magdalene', 'Maggee', 'Maggi', 'Maggie', 'Maggy', 'Maia', 'Mair', 'Maire', 'Maisey', 'Maisie', 'Maitilde', 'Malachi', 'Malanie', 'Malena', 'Malia', 'Malina', 'Malinda', 'Malinde', 'Malissa', 'Malissia', 'Mallissa', 'Mandy', 'Manfred', 'Mannie', 'Manny', 'Mano', 'Manolo', 'Manon', 'Manuel', 'Manya', 'Mar', 'Mara', 'Marabel', 'Marc', 'Marcel', 'Marcela', 'Marcelia', 'Marcella', 'Marcelle', 'Marcellina', 'Marcelline', 'Marcello', 'Marcellus', 'Marcelo', 'Marchall', 'Marchelle', 'Marci', 'Marcia', 'Marcie', 'Marcile', 'Marcille', 'Marco', 'Marcos', 'Marcus', 'Marcy', 'Margaret', 'Margareta', 'Margarete', 'Margaretha', 'Margarethe', 'Margaretta', 'Margarette', 'Margarita', 'Margaux', 'Marge', 'Margeaux', 'Margery', 'Marget', 'Margette', 'Margi', 'Margie', 'Margit', 'Margo', 'Margot', 'Margret', 'Marguerite', 'Margy', 'Mari', 'Maria', 'Mariam', 'Marian', 'Mariana', 'Mariann', 'Marianna', 'Marianne', 'Maribel', 'Maribelle', 'Maribeth', 'Marice', 'Maridel', 'Marie', 'Marie-Ann', 'Marie-Claire', 'Marie-Claude', 'Marie-Jeanne', 'Marie-Laure', 'Marieann', 'Mariejeanne', 'Mariel', 'Mariele', 'Marielle', 'Mariellen', 'Marietta', 'Mariette', 'Marigold', 'Marijn', 'Marijo', 'Marika', 'Marilee', 'Marilyn', 'Marin', 'Marina', 'Marinna', 'Mario', 'Marion', 'Mariquilla', 'Maris', 'Marisa', 'Mariska', 'Marissa', 'Marita', 'Maritsa', 'Marius', 'Mariya', 'Marj', 'Marja', 'Marje', 'Marji', 'Marjie', 'Marjorie', 'Marjory', 'Marjy', 'Mark', 'Marketa', 'Markos', 'Markus', 'Marla', 'Marlane', 'Marleah', 'Marlee', 'Marleen', 'Marlena', 'Marlene', 'Marley', 'Marlie', 'Marlin', 'Marline', 'Marlo', 'Marlon', 'Marlyn', 'Marmaduke', 'Marna', 'Marne', 'Marney', 'Marni', 'Marnia', 'Marnie', 'Marquita', 'Marrilee', 'Marris', 'Marrissa', 'Marsha', 'Marsiella', 'Mart', 'Marta', 'Martainn', 'Martelle', 'Marten', 'Martguerita', 'Martha', 'Marthe', 'Marthena', 'Marti', 'Martica', 'Martie', 'Martin', 'Martina', 'Martino', 'Martita', 'Marty', 'Martyn', 'Martynne', 'Marv', 'Marve', 'Marven', 'Marvin', 'Marwin', 'Mary', 'Marya', 'Maryann', 'Maryanna', 'Maryanne', 'Marybelle', 'Marybeth', 'Maryellen', 'Maryjane', 'Maryjo', 'Maryl', 'Marylee', 'Marylin', 'Marylinda', 'Marylou', 'Marylynne', 'Maryrose', 'Marys', 'Marysa', 'Masha', 'Massimiliano', 'Massimo', 'Mata', 'Matelda', 'Mateo', 'Mathe', 'Mathew', 'Mathian', 'Mathias', 'Mathilda', 'Mathilde', 'Matias', 'Matilda', 'Matilde', 'Matt', 'Matteo', 'Matthaeus', 'Mattheus', 'Matthew', 'Matthias', 'Matthieu', 'Matthiew', 'Matthus', 'Matti', 'Mattias', 'Mattie', 'Matty', 'Maud', 'Maude', 'Maudie', 'Maura', 'Maure', 'Maureen', 'Maureene', 'Maurene', 'Maurice', 'Mauricio', 'Maurie', 'Maurine', 'Maurise', 'Maurita', 'Maurits', 'Maurizia', 'Maurizio', 'Maury', 'Mavis', 'Mavra', 'Max', 'Maxi', 'Maxie', 'Maxim', 'Maximilian', 'Maximilianus', 'Maximilien', 'Maximo', 'Maxine', 'Maybelle', 'Maye', 'Meagan', 'Meaghan', 'Meara', 'Mechelle', 'Meg', 'Megan', 'Megen', 'Meggi', 'Meggie', 'Meggy', 'Meghan', 'Meghann', 'Mehetabel', 'Mei', 'Mel', 'Mela', 'Melamie', 'Melania', 'Melanie', 'Melantha', 'Melany', 'Melba', 'Melesa', 'Melessa', 'Melicent', 'Melina', 'Melinda', 'Melinde', 'Melisa', 'Melisande', 'Melisandra', 'Melisenda', 'Melisent', 'Melissa', 'Melisse', 'Melita', 'Melitta', 'Mella', 'Melli', 'Mellicent', 'Mellie', 'Mellisa', 'Mellisent', 'Melloney', 'Melly', 'Melodee', 'Melodie', 'Melody', 'Melonie', 'Melony', 'Melosa', 'Melva', 'Melvin', 'Melvyn', 'Menard', 'Mercedes', 'Merci', 'Mercie', 'Mercy', 'Meredeth', 'Meredith', 'Meredithe', 'Merell', 'Meridel', 'Meridith', 'Meriel', 'Merilee', 'Merill', 'Merilyn', 'Meris', 'Merissa', 'Merl', 'Merla', 'Merle', 'Merlina', 'Merline', 'Merna', 'Merola', 'Merralee', 'Merrel', 'Merrick', 'Merridie', 'Merrie', 'Merrielle', 'Merrile', 'Merrilee', 'Merrili', 'Merrill', 'Merrily', 'Merv', 'Mervin', 'Merwin', 'Merwyn', 'Meryl', 'Meta', 'Mia', 'Mic', 'Micaela', 'Micah', 'Michael', 'Michaela', 'Michaelina', 'Michaeline', 'Michaella', 'Michail', 'Michal', 'Michale', 'Micheal', 'Micheil', 'Michel', 'Michele', 'Michelina', 'Micheline', 'Michell', 'Michelle', 'Mick', 'Mickey', 'Micki', 'Mickie', 'Micky', 'Midge', 'Miguel', 'Miguela', 'Miguelita', 'Mikael', 'Mikaela', 'Mike', 'Mikel', 'Mikey', 'Mikkel', 'Mikol', 'Mil', 'Mildred', 'Mildrid', 'Mile', 'Milena', 'Miles', 'Milicent', 'Milissent', 'Milka', 'Milli', 'Millicent', 'Millie', 'Millisent', 'Milly', 'Milo', 'Milt', 'Miltie', 'Mimi', 'Min', 'Mina', 'Minda', 'Mindy', 'Minerva', 'Minetta', 'Minette', 'Minna', 'Minnaminnie', 'Minne', 'Minni', 'Minnie', 'Minny', 'Miquela', 'Mira', 'Mirabel', 'Mirabella', 'Mirabelle', 'Miran', 'Miranda', 'Mireielle', 'Mireille', 'Mirella', 'Mirelle', 'Miriam', 'Mirilla', 'Mirna', 'Mischa', 'Misha', 'Missie', 'Missy', 'Misti', 'Misty', 'Mitch', 'Mitzi', 'Modesta', 'Modestia', 'Modestine', 'Modesty', 'Moe', 'Mohammed', 'Mohandas', 'Mohandis', 'Moina', 'Moira', 'Moise', 'Moises', 'Moishe', 'Moll', 'Mollee', 'Molli', 'Mollie', 'Molly', 'Mona', 'Monah', 'Monica', 'Monika', 'Monique', 'Monte', 'Monti', 'Monty', 'Morag', 'Mordecai', 'Moreen', 'Moshe', 'Moyra', 'Muhammad', 'Mureil', 'Murial', 'Muriel', 'Murielle', 'Murvyn', 'Myca', 'Mycah', 'Mychal', 'Myles', 'Mylo', 'Myra', 'Myrah', 'Myranda', 'Myriam', 'Myrilla', 'Myrle', 'Myrlene', 'Myrna', 'Myron', 'Myrta', 'Myrtia', 'Myrtice', 'Myrtie', 'Myrtle', 'Myrvyn', 'Myrwyn', 'Nada', 'Nadean', 'Nadeen', 'Nadia', 'Nadine', 'Nadiya', 'Nady', 'Nadya', 'Nahum', 'Nalani', 'Nan', 'Nana', 'Nananne', 'Nance', 'Nancee', 'Nancey', 'Nanci', 'Nancie', 'Nancy', 'Nanete', 'Nanette', 'Nani', 'Nanice', 'Nanine', 'Nannette', 'Nanni', 'Nannie', 'Nanny', 'Nanon', 'Naoma', 'Naomi', 'Nap', 'Napoleon', 'Natalie', 'Natalina', 'Nataline', 'Natalya', 'Nataniel', 'Natasha', 'Natassia', 'Nate', 'Nathalia', 'Nathalie', 'Nathan', 'Nathanael', 'Nathanial', 'Nathaniel', 'Nathanil', 'Natka', 'Natty', 'Neal', 'Neala', 'Ned', 'Neda', 'Nedda', 'Neddie', 'Neddy', 'Nedi', 'Neel', 'Nehemiah', 'Neil', 'Neila', 'Neile', 'Neilla', 'Neille', 'Neils', 'Nelia', 'Nelie', 'Nell', 'Nelle', 'Nelli', 'Nellie', 'Nelly', 'Nerissa', 'Nerita', 'Nero', 'Neron', 'Nert', 'Nerta', 'Nessa', 'Nessi', 'Nessie', 'Nessy', 'Nesta', 'Nester', 'Netta', 'Netti', 'Nettie', 'Nettle', 'Netty', 'Niall', 'Niccolo', 'Nichol', 'Nichole', 'Nicholle', 'Nick', 'Nickey', 'Nicki', 'Nickie', 'Nicko', 'Nickola', 'Nickolai', 'Nickolas', 'Nickolaus', 'Nicky', 'Nico', 'Nicola', 'Nicolai', 'Nicolais', 'Nicole', 'Nicolea', 'Nicolette', 'Nicoli', 'Nicolina', 'Nicoline', 'Nicolis', 'Nicolle', 'Niel', 'Niels', 'Nigel', 'Nikaniki', 'Nike', 'Niki', 'Nikita', 'Nikki', 'Nikkie', 'Niko', 'Nikola', 'Nikolai', 'Nikolaos', 'Nikolas', 'Nikolaus', 'Nikoletta', 'Nikolia', 'Nikolos', 'Nikos', 'Nil', 'Niles', 'Nils', 'Nilson', 'Nina', 'Ninetta', 'Ninette', 'Ninnetta', 'Ninnette', 'Nita', 'Noah', 'Noak', 'Noam', 'Noami', 'Nobe', 'Nobie', 'Noby', 'Noe', 'Noel', 'Noelani', 'Noell', 'Noella', 'Noelle', 'Noellyn', 'Noelyn', 'Noemi', 'Nona', 'Nonah', 'Noni', 'Nonie', 'Nonna', 'Nonnah', 'Nora', 'Norah', 'Norbert', 'Norbie', 'Norby', 'Norean', 'Noreen', 'Norene', 'Norina', 'Norine', 'Norma', 'Novelia', 'Nyssa', 'Obadiah', 'Obadias', 'Obed', 'Obediah', 'Oberon', 'Obidiah', 'Obie', 'Oby', 'Octavia', 'Octavius', 'Ode', 'Odele', 'Odelia', 'Odelinda', 'Odell', 'Odella', 'Odelle', 'Odessa', 'Odetta', 'Odette', 'Olav', 'Olenka', 'Olenolin', 'Olga', 'Olia', 'Olimpia', 'Olin', 'Olive', 'Oliver', 'Olivero', 'Olivette', 'Olivia', 'Olivie', 'Olivier', 'Oliviero', 'Oliy', 'Ollie', 'Olly', 'Olva', 'Olvan', 'Olwen', 'Olympe', 'Olympia', 'Olympie', 'Omar', 'Omero', 'Ondrea', 'Oneida', 'Onfre', 'Onfroi', 'Onida', 'Onofredo', 'Oona', 'Opal', 'Opalina', 'Opaline', 'Ophelia', 'Ophelie', 'Ora', 'Oralee', 'Oralia', 'Oralie', 'Oralla', 'Oralle', 'Oran', 'Orazio', 'Orbadiah', 'Orel', 'Orelee', 'Orelia', 'Orelie', 'Orella', 'Orelle', 'Oren', 'Oriana', 'Orlan', 'Orland', 'Orlando', 'Orly', 'Orran', 'Orren', 'Orrin', 'Orsa', 'Orsola', 'Orson', 'Ortensia', 'Orv', 'Osbert', 'Otis', 'Ottilie', 'Otto', 'Owen', 'Ozzie', 'Ozzy', 'Pablo', 'Paco', 'Paddie', 'Paddy', 'Padraic', 'Padraig', 'Padriac', 'Paloma', 'Pam', 'Pamela', 'Pamelina', 'Pamella', 'Pammi', 'Pammie', 'Pammy', 'Panchito', 'Pancho', 'Pandora', 'Pansie', 'Pansy', 'Paola', 'Paolina', 'Paolo', 'Paquito', 'Pasquale', 'Pat', 'Patience', 'Patric', 'Patrica', 'Patrice', 'Patricia', 'Patricio', 'Patrick', 'Patrizia', 'Patrizio', 'Patrizius', 'Patsy', 'Patti', 'Pattie', 'Patty', 'Paula', 'Paule', 'Pauletta', 'Paulette', 'Pauli', 'Paulie', 'Paulina', 'Pauline', 'Paulita', 'Paulo', 'Pavel', 'Pavia', 'Pavla', 'Pearl', 'Pearla', 'Pearle', 'Pearline', 'Pebrook', 'Peder', 'Pedro', 'Peggie', 'Peggy', 'Penelopa', 'Penelope', 'Penn', 'Penni', 'Pennie', 'Penny', 'Penrod', 'Pepe', 'Pepi', 'Pepillo', 'Pepita', 'Pepito', 'Pete', 'Peter', 'Peterus', 'Petey', 'Petr', 'Petra', 'Petrina', 'Petronella', 'Petronia', 'Petronilla', 'Petronille', 'Petunia', 'Peyter', 'Peyton', 'Phaedra', 'Phaidra', 'Phebe', 'Phedra', 'Phelia', 'Phil', 'Philbert', 'Philip', 'Philipa', 'Philippa', 'Philippe', 'Philippine', 'Philis', 'Phillida', 'Phillie', 'Phillip', 'Phillipe', 'Phillipp', 'Phillis', 'Philly', 'Philomena', 'Phineas', 'Phip', 'Phoebe', 'Phylis', 'Phyllida', 'Phyllis', 'Phyllys', 'Phylys', 'Pia', 'Pierette', 'Pierre', 'Pierrette', 'Pieter', 'Pietra', 'Pietrek', 'Pietro', 'Piggy', 'Pincas', 'Pinchas', 'Pincus', 'Piotr', 'Pip', 'Pippa', 'Pippo', 'Pippy', 'Polly', 'Pollyanna', 'Poppy', 'Portia', 'Portie', 'Priscella', 'Priscilla', 'Prudence', 'Pyotr', 'Queenie', 'Quent', 'Quentin', 'Quintin', 'Quintina', 'Quinton', 'Quintus', 'Rab', 'Rabbi', 'Rabi', 'Rachael', 'Rachel', 'Rachele', 'Rachelle', 'Rad', 'Rae', 'Raeann', 'Raf', 'Rafa', 'Rafael', 'Rafaela', 'Rafaelia', 'Rafaelita', 'Rafaellle', 'Rafaello', 'Rafe', 'Raff', 'Raffaello', 'Raffarty', 'Rafferty', 'Rafi', 'Ragnar', 'Rahal', 'Rahel', 'Raimondo', 'Raimund', 'Raimundo', 'Raina', 'Raine', 'Rainer', 'Rakel', 'Raleigh', 'Ralf', 'Ralina', 'Ralph', 'Ram', 'Ramon', 'Ramona', 'Ramonda', 'Rana', 'Rance', 'Rancell', 'Randa', 'Randal', 'Randall', 'Randee', 'Randene', 'Randi', 'Randie', 'Randolf', 'Randolph', 'Randy', 'Ranee', 'Rani', 'Rania', 'Ranice', 'Ranique', 'Ranna', 'Ransell', 'Ransom', 'Raoul', 'Raphael', 'Raphaela', 'Raquel', 'Raquela', 'Rasia', 'Rasla', 'Raul', 'Ravi', 'Ravid', 'Raviv', 'Raychel', 'Raye', 'Raymund', 'Rea', 'Reamonn', 'Reba', 'Rebbecca', 'Rebe', 'Rebeca', 'Rebecca', 'Rebecka', 'Rebeka', 'Rebekah', 'Rebekkah', 'Reeta', 'Reeva', 'Reg', 'Regan', 'Regen', 'Reggi', 'Reggie', 'Reggis', 'Reggy', 'Regina', 'Reginald', 'Reginauld', 'Regine', 'Reinald', 'Reinaldo', 'Reinaldos', 'Reine', 'Reinhard', 'Reinhold', 'Reinold', 'Reinwald', 'Rem', 'Remington', 'Remus', 'Remy', 'Rena', 'Renado', 'Renae', 'Renaldo', 'Renard', 'Renata', 'Renate', 'Renato', 'Renaud', 'Rene', 'Renee', 'Renell', 'Renelle', 'Renie', 'Reta', 'Retha', 'Reube', 'Reuben', 'Reuven', 'Revkah', 'Rex', 'Rey', 'Reyna', 'Reynard', 'Reynold', 'Rhea', 'Rheba', 'Rheta', 'Rhett', 'Rhetta', 'Rhiamon', 'Rhianna', 'Rhianon', 'Rhoda', 'Rhodia', 'Rhodie', 'Rhody', 'Rhona', 'Rhonda', 'Rhys', 'Richard', 'Richardo', 'Richart', 'Richie', 'Richy', 'Rici', 'Rick', 'Ricki', 'Rickie', 'Ricky', 'Rik', 'Riki', 'Rikki', 'Rina', 'Rinaldo', 'Ring', 'Ringo', 'Rita', 'Riva', 'Rivalee', 'Rivi', 'Rivkah', 'Rivy', 'Roana', 'Roanna', 'Roanne', 'Rob', 'Robb', 'Robbert', 'Robbi', 'Robbie', 'Robbin', 'Robby', 'Robbyn', 'Robert', 'Roberta', 'Roberto', 'Robin', 'Robina', 'Robyn', 'Rochell', 'Rochella', 'Rochelle', 'Rod', 'Roda', 'Rodd', 'Roddie', 'Roddy', 'Roderic', 'Roderich', 'Roderick', 'Roderigo', 'Rodge', 'Rodger', 'Rodi', 'Rodie', 'Rodina', 'Rodney', 'Rodolfo', 'Rodolph', 'Rodolphe', 'Rodrick', 'Rodrigo', 'Rodrique', 'Roger', 'Rogerio', 'Roland', 'Rolando', 'Rolf', 'Rolfe', 'Rolph', 'Roma', 'Romain', 'Romeo', 'Romola', 'Romona', 'Romonda', 'Romy', 'Ron', 'Rona', 'Ronald', 'Ronalda', 'Ronda', 'Ronica', 'Ronna', 'Ronni', 'Ronnica', 'Ronnie', 'Ronny', 'Rora', 'Rori', 'Rorie', 'Rorke', 'Rory', 'Rosa', 'Rosabel', 'Rosabella', 'Rosabelle', 'Rosaleen', 'Rosalia', 'Rosalie', 'Rosalind', 'Rosalinda', 'Rosalinde', 'Rosaline', 'Rosalyn', 'Rosalynd', 'Rosamond', 'Rosamund', 'Rosana', 'Rosanna', 'Rosanne', 'Rosco', 'Roscoe', 'Roseann', 'Roseanna', 'Roseanne', 'Roselia', 'Roselin', 'Roseline', 'Rosella', 'Roselle', 'Rosemaria', 'Rosemarie', 'Rosemary', 'Rosemonde', 'Rosene', 'Rosetta', 'Rosette', 'Roshelle', 'Rosie', 'Rosina', 'Rosita', 'Roslyn', 'Rosmunda', 'Rosy', 'Rowena', 'Roxana', 'Roxane', 'Roxanna', 'Roxanne', 'Roxi', 'Roxie', 'Roxine', 'Roxy', 'Roy', 'Rozalie', 'Rozalin', 'Rozamond', 'Rozanna', 'Rozanne', 'Ruben', 'Ruby', 'Rudiger', 'Rudolf', 'Rudolfo', 'Rudolph', 'Rudy', 'Rupert', 'Ruperta', 'Ruperto', 'Ruprecht', 'Rurik', 'Russ', 'Rustie', 'Rustin', 'Rusty', 'Rutger', 'Ruth', 'Ruthann', 'Ruthanne', 'Ruthe', 'Ruthi', 'Ruthie', 'Ruthy', 'Sabina', 'Sabine', 'Sabra', 'Sabrina', 'Sacha', 'Sada', 'Sadella', 'Sadie', 'Sadye', 'Saidee', 'Sal', 'Salaidh', 'Saleem', 'Salem', 'Salim', 'Sallee', 'Salli', 'Sallie', 'Sally', 'Sallyann', 'Sallyanne', 'Saloma', 'Salome', 'Salvador', 'Salvatore', 'Salvidor', 'Sam', 'Samantha', 'Samara', 'Samaria', 'Sammie', 'Sammy', 'Samuel', 'Samuele', 'Sancho', 'Sande', 'Sander', 'Sandi', 'Sandie', 'Sandra', 'Sandro', 'Sandy', 'Sandye', 'Sapphira', 'Sapphire', 'Sara', 'Sara-Ann', 'Saraann', 'Sarah', 'Sarajane', 'Saree', 'Sarena', 'Sarene', 'Sarette', 'Sari', 'Sarina', 'Sarine', 'Sarita', 'Sascha', 'Sasha', 'Sashenka', 'Saudra', 'Saul', 'Sauncho', 'Saunder', 'Saundra', 'Sauveur', 'Savina', 'Saw', 'Scarlet', 'Scarlett', 'Schuyler', 'Scot', 'Seamus', 'Sean', 'Seana', 'Sebastian', 'Sebastiano', 'Sebastien', 'See', 'Seka', 'Sela', 'Selena', 'Selene', 'Selestina', 'Selia', 'Selie', 'Selig', 'Selina', 'Selinda', 'Seline', 'Sella', 'Selle', 'Selma', 'Sena', 'Sephira', 'Serena', 'Serene', 'Serge', 'Sergei', 'Sergio', 'Seth', 'Seumas', 'Seward', 'Seymour', 'Shae', 'Shaina', 'Shaine', 'Shalna', 'Shalne', 'Shalom', 'Shamus', 'Shana', 'Shanan', 'Shanda', 'Shandee', 'Shandeigh', 'Shandie', 'Shandra', 'Shandy', 'Shane', 'Shani', 'Shanie', 'Shanna', 'Shannah', 'Shannan', 'Shannen', 'Shannon', 'Shanon', 'Shanta', 'Shantee', 'Shara', 'Sharai', 'Shari', 'Sharia', 'Sharity', 'Sharl', 'Sharla', 'Sharleen', 'Sharlene', 'Sharline', 'Sharon', 'Sharona', 'Sharron', 'Sharyl', 'Shaughn', 'Shaun', 'Shauna', 'Shawn', 'Shawna', 'Shayla', 'Shaylah', 'Shaylyn', 'Shaylynn', 'Shayna', 'Shayne', 'Shea', 'Sheba', 'Sheela', 'Sheelagh', 'Sheelah', 'Sheena', 'Sheeree', 'Sheila', 'Sheila-Kathryn', 'Sheilah', 'Shela', 'Shelagh', 'Shelby', 'Shena', 'Sherri', 'Sheryl', 'Shirlee', 'Shirleen', 'Shirlene', 'Shirley', 'Shirline', 'Sholom', 'Shoshana', 'Shoshanna', 'Shurlock', 'Shurlocke', 'Sibyl', 'Sibylla', 'Sibylle', 'Sid', 'Sidonia', 'Siegfried', 'Siffre', 'Sig', 'Sigfrid', 'Sigfried', 'Sigismond', 'Sigismondo', 'Sigismund', 'Sigismundo', 'Sigmund', 'Sigrid', 'Sigvard', 'Silas', 'Sileas', 'Silvia', 'Silvie', 'Silvio', 'Simeon', 'Simon', 'Simona', 'Simone', 'Simonette', 'Simonne', 'Sindee', 'Siobhan', 'Sissie', 'Sissy', 'Sky', 'Skye', 'Sofia', 'Sofie', 'Sollie', 'Solly', 'Sondra', 'Sonia', 'Sonja', 'Sonni', 'Sonnie', 'Sonnnie', 'Sonny', 'Sonya', 'Sophey', 'Sophi', 'Sophia', 'Sophie', 'Sosanna', 'Spike', 'Stace', 'Stacee', 'Stacey', 'Staci', 'Stacia', 'Stacie', 'Stacy', 'Stafani', 'Stan', 'Stanislas', 'Stanislaus', 'Stanislaw', 'Stanley', 'Stefan', 'Stefania', 'Stefanie', 'Stefano', 'Steffane', 'Steffen', 'Steffi', 'Steffie', 'Stella', 'Stephanie', 'Stephannie', 'Stephanus', 'Stephen', 'Stephenie', 'Stephi', 'Stephie', 'Steve', 'Steven', 'Stevena', 'Stevie', 'Stevy', 'Sue', 'Suellen', 'Sukey', 'Suki', 'Sula', 'Susan', 'Susana', 'Susanetta', 'Susann', 'Susanna', 'Susannah', 'Susanne', 'Susette', 'Susi', 'Susie', 'Susy', 'Suzann', 'Suzanna', 'Suzanne', 'Suzette', 'Suzi', 'Suzie', 'Suzy', 'Sven', 'Svend', 'Swen', 'Sybil', 'Sybila', 'Sybilla', 'Sybille', 'Sybyl', 'Syd', 'Sydel', 'Sydelle', 'Sylas', 'Sylvan', 'Sylvia', 'Syman', 'Symon', 'Tabatha', 'Tabb', 'Tabbatha', 'Tabbitha', 'Tabitha', 'Tad', 'Tadd', 'Taddeo', 'Taddeusz', 'Tadeas', 'Tadeo', 'Tades', 'Tadio', 'Taffy', 'Talia', 'Tallia', 'Tallie', 'Tallou', 'Tallulah', 'Tally', 'Talya', 'Talyah', 'Tam', 'Tamar', 'Tamara', 'Tamarah', 'Tamarra', 'Tamas', 'Tamera', 'Tami', 'Tamiko', 'Tamma', 'Tammara', 'Tammi', 'Tammie', 'Tammy', 'Tanhya', 'Tani', 'Tania', 'Tanitansy', 'Tanya', 'Tara', 'Tarah', 'Tarra', 'Tarrah', 'Tarrance', 'Taryn', 'Tasha', 'Tatiana', 'Tatiania', 'Tatum', 'Teador', 'Ted', 'Tedd', 'Tedda', 'Teddi', 'Teddie', 'Teddy', 'Teodoor', 'Teodor', 'Teodora', 'Teodorico', 'Teodoro', 'Tera', 'Terence', 'Terencio', 'Teresa', 'Terese', 'Teresina', 'Teresita', 'Teressa', 'Teri', 'Teriann', 'Terrance', 'Terrence', 'Terri', 'Terrie', 'Terry', 'Tersina', 'Tess', 'Tessa', 'Tessi', 'Tessie', 'Tessy', 'Thaddeus', 'Thaddus', 'Thadeus', 'Thain', 'Thaine', 'Thalia', 'Thane', 'Thatch', 'Thayne', 'Thea', 'Theadora', 'Thebault', 'Theda', 'Thedric', 'Thedrick', 'Thekla', 'Thelma', 'Theo', 'Theodor', 'Theodora', 'Theodore', 'Theodoric', 'Theodosia', 'Theresa', 'Therese', 'Theresina', 'Theresita', 'Theressa', 'Thia', 'Thibaud', 'Thibaut', 'Thom', 'Thoma', 'Thomasa', 'Thomasin', 'Thomasina', 'Thomasine', 'Thor', 'Tilda', 'Tildi', 'Tildie', 'Tildy', 'Tiler', 'Tillie', 'Tilly', 'Tim', 'Timi', 'Timmi', 'Timmie', 'Timmy', 'Timofei', 'Timoteo', 'Timothea', 'Timothee', 'Timotheus', 'Timothy', 'Tina', 'Tine', 'Tiphani', 'Tiphanie', 'Tiphany', 'Tish', 'Tisha', 'Tito', 'Titos', 'Titus', 'Tobe', 'Tobey', 'Tobi', 'Tobiah', 'Tobias', 'Tobie', 'Toby', 'Tom', 'Toma', 'Tomas', 'Tomasina', 'Tomasine', 'Tomaso', 'Tome', 'Tomi', 'Tommi', 'Tommie', 'Tommy', 'Toni', 'Tonia', 'Tonie', 'Tonnie', 'Tony', 'Tonya', 'Tonye', 'Tootsie', 'Tore', 'Torey', 'Tori', 'Torie', 'Torin', 'Tove', 'Tracee', 'Traci', 'Tracie', 'Trefor', 'Trey', 'Tricia', 'Trina', 'Trip', 'Tripp', 'Tris', 'Trish', 'Trisha', 'Trista', 'Tristam', 'Tristan', 'Trix', 'Trixi', 'Trixie', 'Trixy', 'Troy', 'Truda', 'Trude', 'Trudey', 'Trudi', 'Trudie', 'Trudy', 'Trula', 'Twila', 'Twyla', 'Ty', 'Tybalt', 'Tymothy', 'Ulberto', 'Ulick', 'Ulises', 'Ulla', 'Ulric', 'Ulrica', 'Ulrich', 'Ulrick', 'Ulrika', 'Ulrike', 'Ulysses', 'Umberto', 'Umeko', 'Una', 'Upton', 'Urbain', 'Urban', 'Urbano', 'Urbanus', 'Uri', 'Uriah', 'Uriel', 'Ursa', 'Ursala', 'Ursola', 'Urson', 'Ursula', 'Ursulina', 'Ursuline', 'Uta', 'Vachel', 'Vaclav', 'Vail', 'Val', 'Valaree', 'Valaria', 'Valdemar', 'Vale', 'Valeda', 'Valencia', 'Valene', 'Valenka', 'Valentia', 'Valentijn', 'Valentin', 'Valentina', 'Valeria', 'Valerie', 'Valery', 'Valerye', 'Valida', 'Valina', 'Valle', 'Valli', 'Vallie', 'Vally', 'Valma', 'Vanda', 'Vanessa', 'Vania', 'Vanna', 'Vanni', 'Vannie', 'Vanny', 'Vanya', 'Vasili', 'Vasilis', 'Vasily', 'Vassili', 'Vassily', 'Veda', 'Velma', 'Venus', 'Vera', 'Verena', 'Verene', 'Verge', 'Vergil', 'Veriee', 'Verile', 'Verina', 'Verine', 'Verla', 'Vern', 'Verna', 'Vernon', 'Vernor', 'Veronica', 'Veronika', 'Veronike', 'Veronique', 'Vevay', 'Vi', 'Vic', 'Vick', 'Vicki', 'Vickie', 'Vicky', 'Victoir', 'Victor', 'Victoria', 'Vida', 'Vidovic', 'Vidovik', 'Viki', 'Vikki', 'Vikky', 'Vilhelmina', 'Vilma', 'Vin', 'Vina', 'Vince', 'Vincenz', 'Viola', 'Violante', 'Viole', 'Violet', 'Violetta', 'Violette', 'Virgil', 'Virgilio', 'Virginia', 'Virginie', 'Vita', 'Vite', 'Vitia', 'Vito', 'Vitoria', 'Vittoria', 'Vittorio', 'Viv', 'Vivian', 'Viviana', 'Vivianna', 'Vivianne', 'Vivie', 'Vivien', 'Viviene', 'Vivienne', 'Viviyan', 'Vivyan', 'Vivyanne', 'Vlad', 'Vladamir', 'Vladimir', 'Waldemar', 'Waldo', 'Wallie', 'Wallis', 'Walliw', 'Wally', 'Walt', 'Walther', 'Wanda', 'Wayne', 'Wenda', 'Wendall', 'Wendel', 'Wendeline', 'Wendell', 'Wendi', 'Wendie', 'Wendy', 'Wendye', 'Wenona', 'Wenonah', 'Werner', 'Wernher', 'Wes', 'Wilbert', 'Wilbur', 'Wilburt', 'Wilden', 'Wildon', 'Wileen', 'Wilek', 'Wilfred', 'Wilfrid', 'Wilhelm', 'Wilhelmina', 'Wilhelmine', 'Wilie', 'Will', 'Willa', 'Willabella', 'Willamina', 'Willard', 'Willem', 'Willetta', 'Willette', 'William', 'Willie', 'Willy', 'Wilma', 'Wilmar', 'Wilmer', 'Wilmette', 'Wilona', 'Winfred', 'Wini', 'Winifield', 'Winifred', 'Winnie', 'Winnifred', 'Winny', 'Winona', 'Winonah', 'Wolfgang', 'Wylma', 'Wyn', 'Wyndham', 'Wynn', 'Wynne', 'Wynnie', 'Xavier', 'Xena', 'Xenia', 'Xerxes', 'Ximenes', 'Ximenez', 'Yalonda', 'Yasmeen', 'Yasmin', 'Yehudi', 'Yehudit', 'Yelena', 'Yetta', 'Yettie', 'Yetty', 'Yevette', 'Ynes', 'Ynez', 'Yoko', 'Yolanda', 'Yolande', 'Yolane', 'Yolanthe', 'Yoshi', 'Yoshiko', 'Yovonnda', 'Ysabel', 'Yul', 'Yule', 'Yulma', 'Yuma', 'Yuri', 'Yurik', 'Yves', 'Yvette', 'Yvon', 'Yvonne', 'Yvor', 'Zabrina', 'Zaccaria', 'Zach', 'Zacharia', 'Zachariah', 'Zacharias', 'Zacharie', 'Zachary', 'Zacherie', 'Zachery', 'Zack', 'Zackariah', 'Zahara', 'Zak', 'Zandra', 'Zane', 'Zaneta', 'Zara', 'Zarah', 'Zared', 'Zaria', 'Zarla', 'Zea', 'Zeb', 'Zebadiah', 'Zebedee', 'Zebulen', 'Zebulon', 'Zechariah', 'Zed', 'Zedekiah', 'Zeke', 'Zelda', 'Zelig', 'Zelma', 'Zena', 'Zenia', 'Zerk', 'Zia', 'Zilvia', 'Zita', 'Zitella', 'Zoe', 'Zola', 'Zollie', 'Zolly', 'Zonda', 'Zondra', 'Zonnya', 'Zora', 'Zorah', 'Zorana', 'Zorina', 'Zorine', 'Zsa Zsa', 'Zsazsa', 'Zulema', 'Zuzana'"/>
<rule context="db:surname[not(parent::db:personname/db:firstname[@role='initials'])]" id="surname-context">
&precedingPageNoVariable;
<report test=". = $firstnames" id="surname-is-firstname" role="warning">Should the <name/> element be a firstname? Its content  = <value-of select="."/>, + also check sibling firstname element and that parent personname[@role] is correct &check_ancestor; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

	<!-- SB page numbers -->
	<pattern id="page-numbers">
<title>General tests for page number spans, whether they occur in chunk info, or in biblio items</title>
		<rule context="db:pagenums[not(ancestor::db:book[@outputformat='e-Only'])]" id="pagenums-context">
			<assert test="not(normalize-space(substring(.,1,1)) = '' or normalize-space(substring(.,string-length(.))) = '')" id="pagenums-spaces">Page number spans should have no leading or trailing space; &check_ancestor;</assert>
			<assert test="not(contains(.,'-'))" id="pagenums-ndash-1">Page number spans should be indicated with en-dash (–) rather than hyphens; &check_ancestor;</assert>
			<assert test="not(contains(.,'—'))" id="pagenums-ndash-2">Page number spans should be indicated with en-dash (–) rather than m-dashes; &check_ancestor;</assert>
		</rule>
	</pattern>

<!-- footnotes -->
<pattern id="footnote-checks">
<title>Various tests to warn if footnote content might include something that should be linked or be a bibliographic reference</title>
<rule context="db:footnote[not(ancestor::db:book/db:info/db:biblioid[@otherclass='legalContentType'])]" id="footnote-context-2">
&precedingPageNoVariable;
<report role="warning" test="db:para[db:emphasis[@role='italic']][contains(., '‘')][not(db:link)][not(descendant::db:bibliomixed)]" id="possible-link-biblio-1">Footnote contains italic text and single quote, should it be a biblio item or a link to one? &check_id; &pageNoAndChunkPDF;</report>
<report role="warning" test="db:para[not(element())]/text()[contains(., ', ‘')]" id="possible-link-biblio-2">Footnote para contains no child elements and the string ", ‘" (rsquo), should it be a link to a biblio item? &check_id; &pageNoAndChunkPDF;</report>
<report role="warning" test="db:para/descendant-or-self::node()[self::text()][not(db:indexterm)][not(ancestor::db:bibliomixed[@role='case'])][contains(., ' v ') or contains(., ' v. ') or contains(., ' vs ')]" id="possible-link-biblio-3">Footnote contains "v", "v." or "vs", should it be a biblio item @role=case? &check_id; &pageNoAndChunkPDF;</report>
        <report role="warning" test="db:para[db:emphasis[@role='italic']]/text()[contains(., '2016')][not(parent::db:para/db:link)]" id="link2016">Footnote contains italic text and a date, should it be a biblio item or a link to one? &check_id; &pageNoAndChunkPDF;</report>
        <report role="warning" test="db:para[db:emphasis[@role='italic']]/text()[contains(., '2015')][not(parent::db:para/db:link)]" id="link2015">Footnote contains italic text and a date, should it be a biblio item or a link to one? &check_id; &pageNoAndChunkPDF;</report>
        <report role="warning" test="db:para[db:emphasis[@role='italic']]/text()[contains(., '2014')][not(parent::db:para/db:link)]" id="link2014">Footnote contains italic text and a date, should it be a biblio item or a link to one? &check_id; &pageNoAndChunkPDF;</report>
        <report role="warning" test="db:para[db:emphasis[@role='italic']]/text()[contains(., '2013')][not(parent::db:para/db:link)]" id="possible-link-biblio-4">Footnote contains italic text and a date, should it be a biblio item or a link to one? &check_id; &pageNoAndChunkPDF;</report>
        <report role="warning" test="db:para[db:emphasis[@role='italic']][not(db:link)]/text()[contains(., '2012')][not(parent::db:para/db:link)]" id="link2012">Footnote contains italic text and a date, should it be a biblio item or a link to one? &check_id; &pageNoAndChunkPDF;</report>
        <report role="warning" test="db:para[db:emphasis[@role='italic']][not(db:link)]/text()[contains(., '2011')][not(parent::db:para/db:link)]" id="link2011">Footnote contains italic text and a date, should it be a biblio item or a link to one? &check_id; &pageNoAndChunkPDF;</report>
        <report role="warning" test="db:para[db:emphasis[@role='italic']][not(db:link)]/text()[contains(., '2010')][not(parent::db:para/db:link)]" id="link2010">Footnote contains italic text and a date, should it be a biblio item or a link to one? &check_id; &pageNoAndChunkPDF;</report>
        <report role="warning" test="db:para[db:emphasis[@role='italic']][not(db:link)]/text()[contains(., '2009')][not(parent::db:para/db:link)]" id="link2009">Footnote contains italic text and a date, should it be a biblio item or a link to one? &check_id; &pageNoAndChunkPDF;</report>
        <report role="warning" test="db:para[db:emphasis[@role='italic']][not(db:link)]/text()[contains(., '2008')][not(parent::db:para/db:link)]" id="link2008">Footnote contains italic text and a date, should it be a biblio item or a link to one? &check_id; &pageNoAndChunkPDF;</report>
        <report role="warning" test="db:para[db:emphasis[@role='italic']][not(db:link)]/text()[contains(., '2007')][not(parent::db:para/db:link)]" id="link2007">Footnote contains italic text and a date, should it be a biblio item or a link to one? &check_id; &pageNoAndChunkPDF;</report>
        <report role="warning" test="db:para[db:emphasis[@role='italic']][not(db:link)]/text()[contains(., '2006')][not(parent::db:para/db:link)]" id="link2006">Footnote contains italic text and a date, should it be a biblio item or a link to one? &check_id; &pageNoAndChunkPDF;</report>
        <report role="warning" test="db:para[db:emphasis[@role='italic']][not(db:link)]/text()[contains(., '2005')][not(parent::db:para/db:link)]" id="link2005">Footnote contains italic text and a date, should it be a biblio item or a link to one? &check_id; &pageNoAndChunkPDF;</report>
        <report role="warning" test="db:para[db:emphasis[@role='italic']][not(db:link)]/text()[contains(., '2004')][not(parent::db:para/db:link)]" id="link2004">Footnote contains italic text and a date, should it be a biblio item or a link to one? &check_id; &pageNoAndChunkPDF;</report>
        <report role="warning" test="db:para[db:emphasis[@role='italic']][not(db:link)]/text()[contains(., '2003')][not(parent::db:para/db:link)]" id="link2003">Footnote contains italic text and a date, should it be a biblio item or a link to one? &check_id; &pageNoAndChunkPDF;</report>
        <report role="warning" test="db:para[db:emphasis[@role='italic']][not(db:link)]/text()[contains(., '2002')][not(parent::db:para/db:link)]" id="link2002">Footnote contains italic text and a date, should it be a biblio item or a link to one? &check_id; &pageNoAndChunkPDF;</report>
        <report role="warning" test="db:para[db:emphasis[@role='italic']][not(db:link)]/text()[contains(., '2001')][not(parent::db:para/db:link)]" id="link2001">Footnote contains italic text and a date, should it be a biblio item or a link to one? &check_id; &pageNoAndChunkPDF;</report>
        <report role="warning" test="db:para[db:emphasis[@role='italic']][not(db:link)]/text()[contains(., '2000')][not(parent::db:para/db:link)]" id="link2000">Footnote contains italic text and a date, should it be a biblio item or a link to one? &check_id; &pageNoAndChunkPDF;</report>
</rule>
</pattern>	
<pattern id="footnotes-2">
<rule id="footnote-context-3" context="db:footnote[not(ancestor::db:table) and not(ancestor::db:informaltable)]">
&precedingPageNoVariable;
<report test="local-name(..) = 'para' and count(../node()) = 1" id="footnote-para" role="error">A para contains only a footnote; is there missing text or should the footnote be attached to something (eg title, author name)? &check_id; &pageNoAndChunkPDF;</report>
</rule>
<rule id="footnote-context-4" context="db:footnote[ancestor::db:table or ancestor::db:informaltable]">
&precedingPageNoVariable;
<report test="local-name(..) = 'para' and count(../node()) = 1" id="footnote-para-2" role="warning">A para contains only a footnote; is there missing text or should the footnote be attached to something (eg title, author name)? &check_id; &pageNoAndChunkPDF;</report>
</rule>
</pattern>
	
	<!-- bibliographies -->
	<pattern id='bibliography-xref-checks'>
<title>Bibliographies (not 'Further Reading') should usually be referenced in the text</title>
<rule context="db:book[not(db:info/db:biblioid[@otherclass='allBiblioItemsUnlinked'] = '1')]" id="bibl-count-context">
&precedingPageNoVariable;
<let name="bibliomixedNumber" value="count(//db:bibliomixed)"/>
<let name="bibliomixedLinked" value="count(key('biblio-id', //db:link/@linkend))"/>
<let name="bibliomixedUnlinked" value="$bibliomixedNumber - $bibliomixedLinked"/>
<report id="unlinked-bibliomixed-count" test="$bibliomixedUnlinked gt 0" role="warning">There are <value-of select="$bibliomixedUnlinked"/> unlinked bibliomixed items, of a total of <value-of select="$bibliomixedNumber"/> [= <value-of select="($bibliomixedUnlinked * 100) div $bibliomixedNumber"/> %]. See details in following warnings</report>
</rule>
		<rule context='db:bibliomixed
				[ancestor::db:bibliography]
				[not(matches(ancestor::db:bibliography/db:title, "further reading", "i")) and not(matches(ancestor::db:bibliography/db:info/db:title, "further reading", "i"))][not(ancestor::db:book/db:info/db:biblioid[@otherclass="allBiblioItemsUnlinked"] = "1")]' id="bibl-context-3">
&precedingPageNoVariable;
			<assert role='warning' id='bibliomixed-referenced' test='//*[@linkend = current()/@xml:id]'>"bibliomixed" elements are usually referenced in the text; &check_id;.  &pageNoAndChunkPDF;</assert>
		</rule>
	</pattern>

<pattern id="textual-checks">
<title>Tests in text for features that might need to be links, or which are wrongly encoded</title>
        <rule context="text()" id="text-context">
&precedingPageNoVariable;
            <report test="contains(.,'ﬀ')" id="ligature-ff">A text node contains the ligatured character ﬀ; replace with "ff", &check_ancestor; &pageNoAndChunkPDF;</report>
            <report test="contains(.,'ﬁ')" id="ligature-fi">A text node contains the ligatured character ﬁ; replace with "fi", &check_ancestor; &pageNoAndChunkPDF;</report>
            <report test="contains(.,'ﬂ')" id="ligature-fl">A text node contains the ligatured character ﬂ; replace with "ﬂ", &check_ancestor; &pageNoAndChunkPDF;</report>
            <report test="contains(.,'ﬃ')" id="ligature-ffi">A text node contains the ligatured character ﬃ; replace with "ffi", &check_ancestor; &pageNoAndChunkPDF;</report>
            <report test="contains(.,'ﬄ')" id="ligature-ffl">A text node contains the ligatured character ﬄ; replace with "ffl", &check_ancestor; &pageNoAndChunkPDF;</report>
            <report test="contains(.,'ﬆ')" id="ligature-st">A text node contains the ligatured character ﬆ; replace with "st", &check_ancestor; &pageNoAndChunkPDF;</report>
            <report test="contains(.,'ﬅ')" id="ligature-longst">A text node contains the ligatured character ﬅ (long st ligature); please notify the publisher, &check_ancestor; &pageNoAndChunkPDF;</report>
            <report test="contains(., '&#x003C;') and not(ends-with(., '&#x003C;'))" role="warning" id="less-than">A text node contains the character &#x003C;. is that correct? &check_ancestor; &pageNoAndChunkPDF;</report>
            <report test="contains(., '&#x003E;') and not(starts-with(., '&#x003E;'))" role="warning" id="greater-than">A text node contains the character &#x003E;. is that correct? &check_ancestor; &pageNoAndChunkPDF;</report>
        </rule>
        <rule context="db:emphasis" id="emph-context">
&precedingPageNoVariable;
            <report role="warning" test="following-sibling::text()[1][not(starts-with(.,':') or starts-with(.,'&#x000A;') or starts-with(.,' ') or starts-with(.,'.') or starts-with(.,',') or starts-with(.,';') or starts-with(.,')') or starts-with(.,'(') or starts-with(.,'&#x2019;') or starts-with(.,'&#x201D;') or starts-with(.,'&#x2014;') or starts-with(.,']') or starts-with(.,'?') or starts-with(.,'!') or starts-with(.,'-') or starts-with(.,'/') or matches(., '^[!-,]'))]" id="possible-missing-space">An emphasis element is followed by text node with no space between, &check_ancestor; &pageNoAndChunkPDF;</report>
            <report role="warning" test="preceding-sibling::text()[1][not(ends-with(.,' ') or ends-with(.,'&#x000A;') or ends-with(.,'(') or ends-with(.,'&#x2018;') or ends-with(.,'&#x2014;') or ends-with(.,'&#x201C;') or ends-with(.,'[') or ends-with(.,'-') or ends-with(.,'/'))]" id="possible-missing-space2">An emphasis element is preceded by text node with no space between, &check_ancestor; &pageNoAndChunkPDF;</report>
            <report test="matches(.,'^,$')" role="warning" id="emphasis-comma"><name/> contains only a comma, is that correct? &check_ancestor; &pageNoAndChunkPDF;</report>
            <report test="matches(.,'^\.$')" role="warning" id="emphasis-stop"><name/> contains only a stop, is that correct? &check_ancestor; &pageNoAndChunkPDF;</report>
            <report test="matches(.,'^:$')" role="warning" id="emphasis-colon"><name/> contains only a colon, is that correct? &check_ancestor; &pageNoAndChunkPDF;</report>
            <report test="matches(.,'^;$')" role="warning" id="emphasis-semicolon"><name/> contains only a semicolon, is that correct? &check_ancestor; &pageNoAndChunkPDF;</report>
            <report test="matches(.,'^&#x2018;$')" role="warning" id="emphasis-lsquo"><name/> contains only a &#x2018;, is that correct? &check_ancestor; &pageNoAndChunkPDF;</report>
            <report test="matches(.,'^&#x2019;$')" role="warning" id="emphasis-rsquo"><name/> contains only a &#x2019;, is that correct? &check_ancestor; &pageNoAndChunkPDF;</report>
            <report test="matches(.,'^&#x201C;$')" role="warning" id="emphasis-ldquo"><name/> contains only a &#x201C;, is that correct? &check_ancestor; &pageNoAndChunkPDF;</report>
            <report test="matches(.,'^&#x201D;$')" role="warning" id="emphasis-rdquo"><name/> contains only a &#x201D;, is that correct? &check_ancestor; &pageNoAndChunkPDF;</report>
            <report test="matches(.,'^$')" role="error" id="emphasis-empty"><name/> is empty &check_ancestor;</report>
</rule>
<rule context="db:link" id="link-context-8">
&precedingPageNoVariable;
<!-- Spaces are sometimes missing between links and the access date (if in square brackets) -->
            <report role="warning" test="following-sibling::text()[1][starts-with(.,'[') or starts-with(.,'(')]" id="possible-missing-space3">A link element is followed by text node with no space between, &check_ancestor; &pageNoAndChunkPDF;</report>
        <report test="db:footnote" id="footnote-link">A footnote is not permitted inside a link, &check_ancestor;</report>
</rule>
</pattern>
        
        
        <pattern id="smallcaps">
                <title>Small caps</title>
                <rule context="db:emphasis[@role='smallcaps']" id="emph-smallcaps">
                        <report test="matches(translate(., '.,;:', ''), '^([\p{Lu} ]+)$')" id="smallcaps-test">Small caps contains only upper case, which is wrong. It should either contain initial caps or all lower case, &check_ancestor;</report>
                </rule>
        </pattern>

<pattern id="additional-text-checks">
<title>Further tests within text()</title>
<rule context="text()[not(parent::db:link or parent::db:para[@role='center'])]" id="text-context-2">
&precedingPageNoVariable;
<report test="contains(., '*')" id="asterisk-in-text" role="warning">Text contains asterisk, but is not in a link, or para[@role=center], OK? &check_ancestor; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

<pattern id="abstracts">
<title>Abstract tests</title>
<rule id="abstract-context" context="db:abstract">
&precedingPageNoVariable;
<report test="matches(db:info/db:title, '^Abstract$')" role="error" id="abstract-title">An abstract must not contain a title "Abstract". &check_id;</report>
</rule>
</pattern>

        <pattern id="abstracts2">
                <title>Additional abstract tests</title>
                <rule id="abstract-context2" context="db:abstract[@role='blurb']">
                        <report test="db:info/db:title" id="abstract-error">A book blurb abstract must not contain a title. &check_id;</report>
                </rule>
                <rule id="abstract-context3" context="db:abstract[not(@role='blurb')]">
                        &precedingPageNoVariable;
                        <report test="db:info/db:title" id="abstract-warn">An abstract should not usually contain a title. Is this correct? &check_id; &pageNoAndChunkPDF;</report>
                </rule>
        </pattern>
        
        <pattern id="extract-tests">
<title>Textual tests specifically for pdf extracts and content derived from Biblio</title>
        <rule context="db:abstract[@role='extract']//text() | db:abstract[@role='blurb']//text() | db:personblurb/db:para" id="extract-context">
            <report test="matches(., '[a-z][0-9]')" id="poss-footnote-marker" role="warning">Text string contains letter followed by number; is it a footnote marker that needs to be deleted? &check_ancestor;</report>
            <report test="contains(., '&#x0026;')" role="warning" id="ampersand">A text node contains the character &#x0026;. is that correct? &check_ancestor;</report>
            <report test="contains(., ' em ') or contains(., '/em ')" role="error" id="em-ghost">A text node contains what looks like the ghost of an em element. Delete or add correct markup? &check_ancestor;</report>
            <report test="contains(., ' b ') or contains(., '/b ') or contains(., ' b ') or contains(., '/B ')" role="error" id="b-ghost">A text node contains what looks like the ghost of a b element. Delete or add correct markup? &check_ancestor;</report>
            <report test="contains(., ' i ') or contains(., '/i ') or contains(., '/I ')" role="error" id="i-ghost">A text node contains what looks like the ghost of a i element. Delete or add correct markup? &check_ancestor;</report>
            <report test="contains(., ' div ') or contains(., '/div ')" role="error" id="div-ghost">A text node contains what looks like the ghost of a div element. Delete or add correct markup? &check_ancestor;</report>
            <report test="contains(., '/strong ')" role="error" id="strong-ghost">A text node contains what looks like the ghost of a strong element. Delete or add correct markup? &check_ancestor;</report>
            <report test="contains(., ' br ') or contains(., ' br/')" role="error" id="br-ghost">A text node contains what looks like the ghost of a br element. Delete or add correct markup? &check_ancestor;</report>
            <report test="contains(., 'nbsp') or contains(., ' quot ') or contains(., ' amp ')" role="error" id="entity-ghost">A text node contains what looks like the ghost of an entity (nbsp, quot, amp...). Delete or add correct markup? &check_ancestor;</report>
            <report test="contains(., 'Times New Roman') or contains(., 'Tahoma') or contains(., 'AGaramond')" role="error" id="font-ghost">A text node contains what looks like the ghost of a font name. Delete. &check_ancestor;</report>
        </rule>
</pattern>

<pattern id="full-text-tests">
<title>Textual tests for full text only</title>
<rule context="text()[ancestor::db:book[@role='fullText']][not(ancestor::db:book/db:info/db:biblioid[@otherclass='fiction'] = '1')][not(parent::element()[self::db:link])]" id="fulltext-context">
&precedingPageNoVariable;
            <report role="warning" test="contains(.,'Chapter') and not(ancestor::db:link or parent::db:title or ancestor::db:bibliomixed)" id="possible-chapter-link">A text node containing "Chapter" may need to be a cross reference of some sort, though check that it is not referring to another book entirely, &check_ancestor; &pageNoAndChunkPDF;</report>
            <!--<report role="warning" test="contains(.,'Part ') and not(parent::db:link or parent::db:title or ancestor::db:bibliomixed)" id="possible-part-link">A text node containing "Part" may need to be a cross reference of some sort, though check that it is not referring to another book entirely, &check_ancestor;</report>-->
            <report role="warning" test="contains(.,'Appendix') and not(parent::db:link or parent::db:title or ancestor::db:bibliomixed)" id="possible-appendix-link">A text node containing "Appendix" may need to be a cross reference of some sort, though check that it is not referring to another book entirely, &check_ancestor; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

<pattern id="para-tests">
<title>General tests for issues in paragraphs</title>
<rule context="db:para" id="para-context">
&precedingPageNoVariable;
            <report role="warning" test="text()[contains(., 'See ')][not(following-sibling::db:link or following-sibling::db:bibliolist)]" id="possible-see-link">A text node containing "See" that is not followed by a link may need to be a cross reference of some sort, &check_ancestor; &pageNoAndChunkPDF;</report>
            <report test="@role='impressions' and not(parent::db:colophon)" id="colophon-impressions">A para with @role=impressions must be in the colophon, &check_id; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

<pattern id="para-tests2">
<title>More general tests for issues in paragraphs</title>
<rule context="db:para[not(parent::db:listitem) and not(parent::db:blockquote) and not(parent::db:glossdef) and not(parent::db:legalnotice) and not(parent::db:entry)]" id="para-context2">
&precedingPageNoVariable;
        <report test="matches(descendant::text()[not(ancestor::db:indexterm)][1], '^\p{Ll}') and matches(descendant::text()[not(ancestor::db:emphasis[@role='smallcaps'])][1], '^\p{Ll}')  and matches(descendant::text()[not(ancestor::db:uri)][1], '^\p{Ll}') and not(matches(descendant::text()[1], '^ibid')) and not(matches(descendant::text()[1], '^eg,?\s')) and not(matches(descendant::text()[1], '^cf')) and not(matches(descendant::text()[1], '^n\s'))" id="para-lower-case" role="warning">A para should not normally start with a lower case letter, &ancestor_id; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

	<pattern id='bibliography-checks'>
<title>Warnings for possible cases and irregularly-punctuated items</title>
		<rule context='db:biblioentry | db:bibliomixed' id="bibl-context">
&precedingPageNoVariable;
			<assert role='warning' id='biblioentry-collab-vs' test='not(contains(db:collab/db:orgname, "vs."))'>Collabname contains "vs." - usually indicates this is a case; &check_id;. &pageNoAndChunkPDF;</assert>
			<assert role='warning' id='biblioentry-collab-v-1' test='not(contains(db:collab/db:orgname, "v."))'>Collabname contains "v." - usually indicates this is a case; &check_id;. &pageNoAndChunkPDF;</assert>			
			<assert role='warning' id='biblieontry-collab-v-2' test='not(contains(db:collab/db:orgname, " v "))'>Collabname contains " v " - usually indicates this is a case; &check_id;. &pageNoAndChunkPDF;</assert>		
		</rule>
        <rule context="db:bibliolist[following-sibling::text()[starts-with(., '.')]]" id="bib-list-context">
&precedingPageNoVariable;
            <report test="db:bibliomixed[ends-with(., '.')]" id="bibliomixed-punc">bibliomixed ends with punctuation and the parent bibliolist is followed by punctuation too. &check_id; &pageNoAndChunkPDF;</report>
        </rule>
	</pattern>

<pattern id="bibliolist">
<title>Rules for bibliolist contexts</title>
<rule context="db:bibliolist" id="bibliolist-context2">
&precedingPageNoVariable;
<report role="warning" test="preceding-sibling::text()[1][not(ends-with(.,' ') or ends-with(.,'&#x000A;') or ends-with(.,'(') or ends-with(.,'&#x2018;') or ends-with(.,'&#x2014;') or ends-with(.,'&#x201C;') or ends-with(.,'[') or ends-with(.,'-') or ends-with(.,'/'))]" id="possible-missing-space4">A bibliolist element is preceded by text node with no space between, &check_ancestor; &pageNoAndChunkPDF;</report>
</rule>
</pattern>
	
<pattern id="bibliomixed-title">
<title>Title formatting in biblio items</title>
<rule context="db:bibliomixed[@role='monograph']/db:title[db:emphasis] | db:bibliomixed[@role='serial']/db:title[db:emphasis] | db:bibliomixed[@role='contribution']/db:bibliomset[@relation='book']/db:title[db:emphasis] | db:bibliomixed[@role='article']/db:bibliomset[@relation='journal']/db:title[db:emphasis]" id="bib-title-context-2">
&precedingPageNoVariable;
<assert test="string-length() = (string-length(db:emphasis[1]) + string-length(db:emphasis[2]) + string-length(db:emphasis[3]) + string-length(db:emphasis[4]))" role="warning" id="title-emphasis">Not all the book/journal title is within an emphasis element, is that correct? &check_ancestor; &pageNoAndChunkPDF;</assert>
</rule>
</pattern>

<pattern id="bibliomixed-title-2">
<title>More bibliomixed title issues</title>
<rule context="db:bibliomixed//db:title | db:bibliomixed//db:subtitle | db:bibliomixed//db:pagenums | db:bibliomixed//db:volumenum | db:bibliomixed//db:address | db:bibliomixed//db:issuenum" id="bib-context-3">
&precedingPageNoVariable;
<report test="ends-with(., '.')" id="ends-with-stop" role="warning">Bibliomixed <name/> ends with a stop. It needs to be outside the <name/> unless it is the end of an abbreviation, &check_ancestor; &pageNoAndChunkPDF;</report>
<report test="ends-with(., ',')" id="ends-with-comma" role="warning">Bibliomixed <name/> ends with a comma. It needs to be outside the <name/>, &check_ancestor; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

<pattern id="bibliomixed-spaces">
<title>Missing spaces in bibliomixed</title>
<rule context="db:bibliomixed//db:author[not(@condition='hidden')] | db:bibliomixed//db:editor[not(@condition='hidden')]" id="hidden-context">
&precedingPageNoVariable;
<report test="following-sibling::node()[1][self::db:title]" role="warning" id="author-title-space">There is no space between the <name/> and the following title, &check_ancestor; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

	<pattern id='bibliography-checks-monograph'>
<title>Basic tests for bibliomixed[@role=monograph]</title>
		<rule context='db:biblioentry[@role="monograph"]| db:bibliomixed[@role="monograph"]' id="mon-context">
&precedingPageNoVariable;
			<assert id='monograph-title' test="descendant::db:title">Monograph "<name/>" elements must have a title; &check_id;. &pageNoAndChunkPDF;</assert>
			<assert id='monograph-authors' test='db:authorgroup or db:author or db:editor' role="warning">Monograph "<name/>" elements should usually have at least one author or editor; &check_id; &pageNoAndChunkPDF;</assert>
            <report test="db:biblioset[@relation='article']|db:bibliomset[@relation='article']" id="mono-not-article">Monographs must not contain an 'article'; should be a 'part' and the <name/> needs a @role=contribution &check_id; &pageNoAndChunkPDF;</report>
            <report test="db:biblioset[@relation='journal']|db:bibliomset[@relation='journal']" id="mono-not-journal">Monographs must not contain a 'journal'; should probably be a 'book' and change bibliomixed[@role] accordingly &check_id; &pageNoAndChunkPDF;</report>
            <report test="db:bibliomset[@relation='book']" id="mono-book">A monograph biblio item must not contain a bibliomset 'book'; that is only permitted in a 'contribution', &check_id; &pageNoAndChunkPDF;</report>
            <report test="db:link[@xlink:href] and not(descendant::db:publishername and descendant::db:address and descendant::db:pubdate)" role="warning" id="mono-url">This work marked as a monograph has a web address. Is @role=monograph correct? &check_id; &pageNoAndChunkPDF;</report>
            <assert test="descendant::db:publishername or descendant::db:address" role="warning" id="possible-short-form-ref">Bibliomixed does not have a publishername or address; is this some other sort of bibliomixed, or a short-form reference that should be a link rather than a bibliomixed? &check_id; &pageNoAndChunkPDF;</assert>
		</rule>		
	</pattern>

<pattern id="bibliography-contribution">
<title>Basic tests for bibliomixed[@role=contribution]</title>
<rule context="db:biblioentry[@role='contribution']| db:bibliomixed[@role='contribution']" id="contribution-context">
            <report test="db:biblioset[@relation='article']|db:bibliomset[@relation='article']" id="contribution-not-article">Contributions in books must not contain an 'article'; should be a 'part' &check_id;</report>
            <report test="db:biblioset[@relation='journal']|db:bibliomset[@relation='journal']" id="contribution-not-journal">Chapters in books must not contain a 'journal'; should probably be a 'book' &check_id;</report>
            <assert test="db:biblioset[@relation='part']|db:bibliomset[@relation='part']" id="contribution-part">An item in a edited book needs to contain a part bibliomset/biblioset &check_id;</assert>
            <assert test="db:biblioset[@relation='book']|db:bibliomset[@relation='book']" id="contribution-book">An item in a book/monograph needs to contain a book bibliomset/biblioset &check_id;</assert>
            <report test="db:link[@xlink:href]" role="warning" id="contribution-url">This work marked as a contribution has a web address. Is @role=contribution correct? &check_id;</report>
</rule>
</pattern>	

<pattern id="bibliography-article">
<title>Basic tests for bibliomixed[@role=article]</title>
<rule context="db:biblioentry[@role='article']| db:bibliomixed[@role='article']" id="article-context-3">
            <report test="db:biblioset[@relation='part']|db:bibliomset[@relation='part']" id="article-not-part">Items in journals/serial/magazines must not contain a 'part'; should be a 'article' &check_id;</report>
            <report test="db:biblioset[@relation='book']|db:bibliomset[@relation='book']" id="article-not-book">Journals/serials/magazines must not contain a 'book'; should probably be a 'journal' &check_id;</report>
            <assert test="db:biblioset[@relation='journal']|db:bibliomset[@relation='journal']" id="article-journal">A journal article needs to contain a journal bibliomset/biblioset &check_id;</assert>
            <assert test="db:biblioset[@relation='article']|db:bibliomset[@relation='article']" id="article-article">A journal article needs to contain a article bibliomset/biblioset &check_id;</assert>
            <report test="descendant::db:publishername" id="pubname-in-article" role="warning">A bibliomixed[@role=article] should not normally contain a publishername. Does it contain an editor? Is this really a contribution? &check_id;</report>
</rule>
</pattern>

<pattern id="bibliography-bibliomset">
<title>Tests for other bibliomset-related issues</title>
<rule context="db:bibliomixed[@role='contribution'] | db:bibliomixed[@role='article']" id="bibliomset-context">
<report test="element()[not(self::db:bibliomset)]" role="warning" id="element-not-bibliomset">Biblio item contains <name path="element()[not(self::db:bibliomset)][1]"/> element that is not in a bibliomset, which is very unusual. Is that correct? &check_id;</report>
</rule>
</pattern>

	<pattern id='bibliography-checks-serial-1'>
<title>Basic tests for bibliomixed[@role=serial]</title>
		<rule context="db:biblioentry[@role='serial']|db:bibliomixed[@role='serial']" id="serial-context">
			<report id='serial-author' test="descendant::db:author">Serial "<name/>" elements must not have an author; &check_id;.</report>
		</rule>
	</pattern>
	
	<pattern id='bibliography-checks-pubdate'>
<title>Dates in bibliomixed</title>
	        <rule context="db:bibliomixed[not(@role='unpublished' or @role='case' or @role='legislation' or @role='series' or @role='website' or @role='message' or @role='other' or @role='recording' or @role='film')]" id="bib-date-context">
			<assert role='warning' test="descendant::db:pubdate" id="bibliomixed-pubdate">A bibliomixed should usually have a pubdate; the "date" element (if used) is for other dates in the record. Or, is this a short form reference that should just be a link to the primary ref; or maybe it is an unpublished or legal item? &check_id;.</assert>
		</rule>
		<rule context="db:bibliomixed[@role='unpublished']" id="unpub-context">
			<report role='error' test="descendant::db:pubdate" id="unpublished-pubdate">A unpublished bibliomixed should not have a pubdate; use the "date" element (or confdates if it is a conference) &check_id;.</report>
			<report role='error' test="descendant::db:publishername" id="unpublished-publishername">A unpublished bibliomixed should not have a publishername; use the "orgname" element (or confsponsor if it is a conference) &check_id;.</report>
		</rule>
	</pattern>

	<pattern id='bibliography-checks-contents'>
<title>General content checks for bibliomixed and its components</title>
<rule context="db:bibliomixed" id="bib-context-4">
            <report role="warning" test="count(descendant::db:pubdate) &gt; 1" id="bibliomixed-multiple-pubdate">Bibliographic references probably should not contain more than one pubdate. One of them may need to be a "date" &check_id;</report>
            <report test="descendant::db:authorgroup" id="bibliomixed-authorgroup">authorgroup must not be in a bibliomixed; remove it and ensure punctuation, words and spacing between child elements is as in the print edition &check_id;</report>
            <report test="descendant::db:biblioid[not(@otherclass='refNo')]" id="bibliomixed-biblioid">bibliomixed should not contain a biblioid; if it is a uri, encode as a link &check_id;</report>
            <report test="descendant::db:publisher" id="bibliomixed-publisher">bibliomixed should not contain publisher (since it can't contain punctuation between components). &check_id;</report>
            <report role="warning" test="count(descendant::db:publishername) &gt; 1" id="bibliomixed-multiple-publishername">bibliomixed contains more than one publishername, which may not be right. &check_id;</report>
            <report test="descendant::db:author/following-sibling::db:author[not(preceding-sibling::text())]" id="bibliomixed-successive-authors">bibliomixed contains multiple, successive authors with no punctuation or text between them. &check_id;</report>
            <report test="descendant::db:editor/following-sibling::db:editor[not(preceding-sibling::text())]" id="bibliomixed-successive-editors">bibliomixed contains multiple, successive editors with no punctuation or text between them. &check_id;</report>
            <report test="db:bibliomset[@relation='originalLang'] or db:bibliomset[@relation='translation'] or db:bibliomset[@relation='otherEdition']" role="information" id="other-editions-etc">Biblio item contains bibliomset @relation=<value-of select="db:bibliomset/@relation"/>, &check_id;</report>
		</rule>
        <rule context="db:bibliomset[@relation='part']" id="bib-part-context">
            <report role="warning" test="db:editor" id="part-editor">It is very unusual to have an editor in a bibliomset "part". Is this correct? &check_ancestor;</report>
            <assert role="warning" test="db:author or db:bibliomisc[@role='anon']" id="part-author">It is very unusual not to have an author in a bibliomset "part". Is this correct? Is there an implied or anonymous author? &check_ancestor;</assert>
        </rule>
        <rule context="db:bibliomset[@relation='article']" id="bibliomset-article-context">
            <report role="warning" test="db:editor" id="article-editor">It is very unusual to have an editor in a bibliomset "article". Is this correct? &check_ancestor;</report>
        </rule>
        <rule context="db:bibliomixed/db:address | db:bibliomset/db:address" id="bib-address-context">
            <assert test="db:street | db:city | db:state | db:country | db:pob | db:postcode | db:otheraddr | db:link | db:orgname" id="bibliomixed-address">Addresses in bibliographies must have their components marked up, &check_ancestor;</assert>
        </rule>
        <rule context="db:bibliomixed//db:title | db:bibliomixed//db:subtitle | db:bibliomixed//db:conftitle" id="bib-titles-context">
            <report test="starts-with(., '&#x2018;') or starts-with(., '&#x201C;')" role="warning" id="bib-title-start-quote"><name/> in biblio item starts with single or double quote; should it be outside the title? &check_ancestor;</report>
            <report test="ends-with(., '&#x2019;') or ends-with(., '&#x201D;')" role="warning" id="bib-title-end-quote"><name/> in biblio item ends with single or double quote; should it be outside the title? &check_ancestor;</report>
            <report test="db:author or db:editor or db:othercredit or db:authorgroup or db:pagenums or db:volumenum or db:issuenum or db:pubdate or db:publishername" id="bad-title-content">The bibliomixed/<name/> contains elements that are not allowed. A <name/> normally just contains formatting markup. &check_ancestor; </report>
        </rule>
	</pattern>

<pattern id="bib-tests-more">
<title>Wrongly marked up editors or translators etc</title>
<rule context="db:bibliomixed/db:author | db:bibliomset/db:author" id="bib-tests-author">
            <report test="contains(preceding-sibling::node()[1], 'Translated by') or contains(preceding-sibling::node()[1], 'translated by') or contains(preceding-sibling::node()[1], 'Translator') or contains(preceding-sibling::node()[1], 'translator')" id="trans-not-au" role="warning">An author is preceded by the text 'translated by' or 'translator', so should author be othercredit[@class=translator]?, &check_id;</report>
            <report test="contains(preceding-sibling::node()[1], 'Edited by') or contains(preceding-sibling::node()[1], 'edited by') or contains(preceding-sibling::node()[1], 'Editor') or contains(preceding-sibling::node()[1], 'editor')" id="ed-not-au" role="warning">An author is preceded by the text 'edited by' or 'editor', so should author be editor?, &check_id;</report>
</rule>
<rule context="db:bibliomixed/db:editor | db:bibliomset/db:editor" id="bib-tests-editor">
            <report test="contains(preceding-sibling::node()[1], 'Translated by') or contains(preceding-sibling::node()[1], 'translated by') or contains(preceding-sibling::node()[1], 'Translator') or contains(preceding-sibling::node()[1], 'translator')" id="trans-not-ed" role="warning">An editor is preceded by the text 'translated by' or 'translator', so should editor be othercredit[@class=translator]?, &check_id;</report>
</rule>
</pattern>

<pattern id="more-biblio-tests">
<title>Further tests for bibliomixed content</title>
        <rule context="db:bibliomixed//db:author[not(@condition='hidden')] | db:bibliomixed//db:editor[not(@condition='hidden')] | db:bibliomixed//db:othercredit[not(@condition='hidden')]" id="bib-name-context">
&precedingPageNoVariable;
                <assert test="if (following-sibling::element()) then (following-sibling::element()[1]/preceding-sibling::node()[1][self::text()]) else 1" role="warning" id="bibliomixed-successive-contributors">bibliomixed contains a <name/> with no punctuation or text between it and the following <name path="following-sibling::element()[1]"/>. &check_ancestor; &pageNoAndChunkPDF;</assert>
            <report test="following-sibling::text()[1][starts-with(.,'(')]" role="warning" id="name-bracket">A <name/> element is followed by an opening bracket and no space between, &check_ancestor; &pageNoAndChunkPDF;</report>
</rule>
<rule context="db:bibliomixed//db:publishername" id="bib-pubname-context">
&precedingPageNoVariable;
        <assert test="if (preceding-sibling::element()) then (preceding-sibling::element()[1]/following-sibling::node()[1][self::text()]) else 1" role="warning" id="bibliomixed-publishername-space">bibliomixed contains a <name/> with no punctuation or text between it and the preceding <name path="preceding-sibling::element()[1]"/>. &check_ancestor; &pageNoAndChunkPDF;</assert>
</rule>
<rule context="db:bibliomixed//db:address" id="bib-address-context-2">
&precedingPageNoVariable;
            <report test="following-sibling::text()[1][starts-with(.,'(')]" role="warning" id="bracket-following-address">A <name/> element is followed by an opening bracket and no space between, &check_ancestor; &pageNoAndChunkPDF;</report>
            <report test="preceding-sibling::text()[1][not(matches(.,'\s[!-\(\[]?$'))]" role="warning" id="no-space-before-address">A <name/> element does not have a space before it, &check_ancestor; &pageNoAndChunkPDF;</report>
        <assert test="if (preceding-sibling::element()) then (preceding-sibling::element()[1]/following-sibling::node()[1][self::text()]) else 1" role="warning" id="bibliomixed-address-space">bibliomixed contains a <name/> with no punctuation or text between it and the preceding <name path="preceding-sibling::element()[1]"/>. &check_ancestor; &pageNoAndChunkPDF;</assert>
</rule>
<rule context="db:bibliomixed//db:title" id="bib-title-context-4">
&precedingPageNoVariable;
            <report test="preceding-sibling::text()[1][preceding-sibling::element()][not(ends-with(.,' ') or ends-with(.,' (') or ends-with(.,' “') or ends-with(., ' &#x2018;') or matches(.,'\s[!-\(]?$'))]" role="warning" id="no-space-before-title">A <name/> element does not have a space before it, &check_ancestor; &pageNoAndChunkPDF;</report>
</rule>
        <rule context="db:bibliomixed//db:author//db:orgname | db:bibliomixed//db:editor//db:orgname | db:bibliomixed//db:othercredit//db:orgname" id="bib-orgname-context">
                <report test="db:emphasis" id="orgname-emphasis" role="warning">An <name/> contains emphasis. Is that correct? &check_ancestor;</report>
</rule>
</pattern>

<pattern id="bibl-yet-more">
        <title>Unbalanced brackets in biblio items</title>
        <rule context="db:bibliomixed//db:city | db:bibliomixed//db:state | db:bibliomixed//db:pubdate | db:bibliomixed//db:publishername | db:bibliomixed//db:title | db:bibliomixed//db:subtitle" id="bib-items-context">
                <report test="starts-with(translate(., ' ', ''), '(') and  not(ends-with(translate(., ' ', ''), ')'))" role="warning" id="bib-bracks-1"><name/> in biblio item starts with a bracket, but does not end with one; are brackets in correct place? There should not be one in a <name/>? &check_ancestor;</report>
                <report test="ends-with(translate(., ' ', ''), ')') and  not(starts-with(translate(., ' ', ''), '('))" role="warning" id="bib-bracks-2"><name/> in biblio item ends with a bracket, but does not starts with one; are brackets in correct place? There should not be one in a <name/>? &check_ancestor;</report>
                <report test="starts-with(translate(., ' ', ''), '[') and  not(ends-with(translate(., ' ', ''), ']'))" role="warning" id="bib-sqbracks-1"><name/> in biblio item starts with a square bracket, but does not end with one; are brackets in correct place? There should not be one in a <name/>? &check_ancestor;</report>
                <report test="ends-with(translate(., ' ', ''), ']') and  not(starts-with(translate(., ' ', ''), '['))" role="warning" id="bib-sqbracks-2"><name/> in biblio item ends with a square bracket, but does not starts with one; are brackets in correct place? There should not be one in a <name/>? &check_ancestor;</report>
                <report test="starts-with(translate(., ' ', ''), '‘') and  not(ends-with(translate(., ' ', ''), '’'))" role="warning" id="bib-quote-1"><name/> in biblio item starts with a quote, but does not end with one; are brackets in correct place? There should not be one in a <name/>? &check_ancestor;</report>
                <report test="ends-with(translate(., ' ', ''), '’') and  not(starts-with(translate(., ' ', ''), '‘'))" role="warning" id="bib-quote-2"><name/> in biblio item ends with a quote, but does not starts with one; are brackets in correct place? There should not be one in a <name/>? &check_ancestor;</report>
        </rule>
</pattern>

<pattern id="bibliography-text-strings">
<title>Various texts strings that may require special handling or testing in bibliomixed or links</title>
<rule context="db:bibliomixed//text()[matches(., 'Anon')][not(parent::db:title)] | db:bibliomixed//text()[matches(., ' anon')][not(parent::db:title)]" id="anon-context">
&precedingPageNoVariable;
<assert test="parent::db:bibliomisc[@role='anon']" role="warning" id="anon-present">The string "Anon" or "anon" is in a biblio item, but not marked as bibliomisc[@role=anon]. Is it an anonymous author? &check_ancestor; &pageNoAndChunkPDF;</assert>
</rule>
<rule context="db:link[matches(., 'ibid\.?\W')] | db:link[matches(., 'Ibid')] | db:link[matches(., 'op\. cit')] | db:link[matches(., 'op\.cit')] | db:link[matches(., 'Op\. cit')] | db:link[matches(., 'Op\.cit')] | db:link[matches(., 'Loc\. cit')] | db:link[matches(., 'Loc\.cit')] | db:link[matches(., 'loc\.cit')] | db:link[matches(., 'loc\. cit')]" id="opcit-context">
<assert test="db:alt" id="alt-required" role="warning">Where there is an ibid/op cit/loc cit in a link, there must also be an alt, &check_ancestor;</assert>
</rule>
<rule context="db:bibliomset" id="bibliomset-context-2">
&precedingPageNoVariable;
<report test="preceding-sibling::text()[ends-with(., ' in') or ends-with(., ' In') or ends-with(., ' In:') or ends-with(., ' to')]" id="space-before-bibliomset-required">There is no space between the word "in" or "to" and the following bibliomset, &check_ancestor; &pageNoAndChunkPDF;</report>
</rule>
<rule context="db:date[@role='accessed']" id="access-date-context">
&precedingPageNoVariable;
<report test="preceding-sibling::text()[ends-with(., 'accessed') or ends-with(., 'Accessed') or ends-with(., 'retrieved') or ends-with(., 'Retrieved')]" id="space-before-access-required">There is no space between the word "accessed" or "retrieved" and the following date, &check_ancestor; &pageNoAndChunkPDF;</report>
</rule>
<!-- These must only apply to full text books -->
<rule context="text()[matches(., 'Op\. cit\.')][ancestor::db:book[@role='fullText']] | text()[matches(., 'op\. cit\.')][ancestor::db:book[@role='fullText']] | text()[matches(., 'op\.cit\.')][ancestor::db:book[@role='fullText']] | text()[matches(., 'Op\.cit\.')][ancestor::db:book[@role='fullText']]" id="opcit-context-2">
&precedingPageNoVariable;
<assert test="ancestor::db:bibliomixed or ancestor::db:link" id="op-cit-present" role="warning">There is an "op cit" in text that is not in a bibliomixed or link, &check_id; &pageNoAndChunkPDF;</assert>
</rule>
<rule context="text()[matches(., ' Ibid')][ancestor::db:book[@role='fullText']] | text()[matches(., ' ibid')][ancestor::db:book[@role='fullText']]" id="ibid-context">
&precedingPageNoVariable;
<assert test="ancestor::db:bibliomixed or ancestor::db:link" id="ibid-present" role="warning">"Ibid" or "ibid" in text that is not in a bibliomixed or link, &check_id; &pageNoAndChunkPDF;</assert>
</rule>
<rule context="text()[matches(., 'loc\. cit\.')][ancestor::db:book[@role='fullText']] | text()[matches(., 'loc\.cit\.')][ancestor::db:book[@role='fullText']] | text()[matches(., 'Loc\. cit\.')][ancestor::db:book[@role='fullText']] | text()[matches(., 'Loc\.cit\.')][ancestor::db:book[@role='fullText']] | text()[matches(., 'loc cit')][ancestor::db:book[@role='fullText']] | text()[matches(., 'Loc cit')][ancestor::db:book[@role='fullText']]" id="loccit-context">
&precedingPageNoVariable;
<assert test="ancestor::db:bibliomixed or ancestor::db:link" id="loc-cit-present">There is a "loc cit" in text that is not in a bibliomixed or link, &check_id; &pageNoAndChunkPDF;</assert>
</rule>
<!-- Conferences -->
<rule context="db:bibliomixed[not(@role='unpublished')]" id="not-unpub-context">
            <report role="warning" test="(contains(., 'Meeting') or contains(., 'Conference') or contains(., 'Convention ') or contains(., 'Presented')) and not(contains(., 'Proceedings'))" id="possible-conference">Biblio item sub/title contains the word "Meeting", "Conference", "Convention" or "Presented"; should this be an @role=unpublished conference? &check_id;</report>
            <report role="warning" test="contains(., 'unpublished') or contains(., 'Unpublished')" id="possible-unpublished">Biblio item contains the word "unpublished"; should this be an @role=unpublished item? &check_id;</report>
            <report role="warning" test="contains(., 'PhD') or contains(., 'Ph.D.') or contains(., 'Thesis') or contains(., ' thesis') or contains(., 'Dissertation') or contains(., 'dissertation') or contains(., 'Tese Doutorado') or contains(., 'Dissertação')" id="possible-unpublished-2">Biblio item contains the text "PhD", "thesis", "dissertation" or a related word; should this be an @role=unpublished item? &check_id;</report>
            <report role="warning" test="contains(., 'personal communication') or contains(., 'Personal communication') or contains(., 'pers. comm.')" id="possible-unpublished-3">Biblio item contains the text "personal communication"; should this be an @role=unpublished item? &check_id;</report>
            <report role="warning" test="contains(., 'interview') or contains(., 'Interview')" id="possible-unpublished-4">Biblio item contains the text "interview"; should this be an @role=unpublished item? &check_id;</report>
<report test="descendant::db:confgroup" role="warning" id="confgroup-present">A bibliomixed with @role=<value-of select="@role"/> contains a confgroup which is very unusual. Is that correct? &check_id;</report>
</rule>
</pattern>
        
        <pattern id="bibliography-text-checks-1a">
                <title>More tests for strings in bibliomixed</title>
                <rule context="db:bibliomixed//text()[contains(., 'Dissertation')]" id="dissertation-context">
                        <report test="parent::db:city | parent::db:publishername | parent::db:volumenum | parent::db:pubdate | parent::db:issuenum | parent::db:firstname | parent::db:surname | parent::db:othername | parent::db:lineage | parent::db:honorific" id="dissertation-location">The text "Dissertation" is in a <name path="parent::node()"/> element, &check_ancestor;</report>
                </rule>
        </pattern>

<pattern id="bibliography-text-checks-2">
<title>Untagged dates</title>
<rule context="db:bibliomixed[not(@role='website')]//text()[matches(., 'January') or matches(., 'February') or matches(., 'March') or matches(., 'April') or matches(., 'May') or matches(., 'June') or matches(., 'July') or matches(., 'August') or matches(., 'September') or matches(., 'October') or matches(., 'November') or matches(., 'December') or matches(., ' Jan ') or matches(., ' Feb ') or matches(., ' Mar ') or matches(., ' Apr ') or matches(., ' Jun ') or matches(., ' Jul ') or matches(., ' Aug ') or matches(., ' Sept ') or matches(., ' Sep ') or matches(., ' Oct ') or matches(., ' Nov ') or matches(., ' Dec ')] | db:bibliomixed/text()[matches(., 'January') or matches(., 'February') or matches(., 'March') or matches(., 'April') or matches(.[not(self::db:author or self::db:editor or self::db:othercredit)], 'May,') or matches(.[not(self::db:author or self::db:editor or self::db:othercredit)], 'May ') or matches(., 'June') or matches(., 'July') or matches(., 'August') or matches(., 'September') or matches(., 'October') or matches(., 'November') or matches(., 'December') or matches(., ' Jan ') or matches(., ' Feb ') or matches(., ' Mar ') or matches(., ' Apr ') or matches(., ' Jun ') or matches(., ' Jul ') or matches(., ' Aug ') or matches(., ' Sept ') or matches(., ' Sep ') or matches(., ' Oct ') or matches(., ' Nov ') or matches(., ' Dec ')]" id="bib-month-context">
<assert test="ancestor::db:title or ancestor::db:subtitle or parent::db:date or parent::db:pubdate or parent::db:surname or parent::db:firstname or parent::db:confdates or parent::db:conftitle or parent::db:uri or parent::db:bibliomisc" role="warning" id="untagged-month">Bibliomixed contains a month but it is not within a date, pubdate, or confdates element, &check_ancestor;</assert>
</rule>
</pattern>

<pattern id="untagged-bibliographies">
<title>How much of a bibliographic item is untagged?</title>
        <rule context="db:bibliomixed[not(@role='recording') and not(@role='film') and  not(@role='message') and not(@role='case') and not(@role='legislation')]" id="untagged-bib-context">
&precedingPageNoVariable;
<let name="stringLength" value="string-length()"/>
<let name="untaggedString" value="string-join((text(),db:bibliomset/text()) , '')"/>
<let name="untagged" value="concat($untaggedString,'')"/>
<let name="untaggedLength" value="string-length($untagged)"/>
<let name="percent" value="$untaggedLength * 100 div $stringLength" />
<report test="$percent gt 29.9" role="warning" id="untagged-biblio-content">Possible untagged content in biblio item. percent = <value-of select="$percent"/>% [untagged content = <value-of select="$untaggedString"/>] untaggedLength = <value-of select="$untaggedLength"/>; total = <value-of select="$stringLength"/>; &check_id;</report>
<report test="$stringLength lt 48" role="warning" id="short-biblio">Biblio item is very short (=<value-of select="$stringLength"/> characters); is it a full biblio reference or should it be a link to the expanded form elsewhere? &check_id; &pageNoAndChunkPDF;</report>
</rule>

</pattern>
<pattern id="bibliography-style">
<title>Person name style in bibliographic references</title> 
<rule context="db:bibliography | db:bibliolist | db:bibliodiv" id="bib-name-style-context">
<let name="first-last" value="count(db:bibliomixed/element()[1]/db:personname[1][@role='first-last']) + count(db:bibliomixed/db:bibliomset[1]/element()[1]/db:personname[1][@role='first-last'])"/>
<let name="last-first" value="count(db:bibliomixed/element()[1]/db:personname[1][@role='last-first']) + count(db:bibliomixed/db:bibliomset[1]/element()[1]/db:personname[1][@role='last-first'])"/>
<report role="warning" id="mixed-personname-style" test="(db:bibliomixed/element()[1]/db:personname[1][@role='first-last'] or db:bibliomixed/db:bibliomset[1]/element()[1]/db:personname[1][@role='first-last']) and (db:bibliomixed/element()[1]/descendant::db:personname[1][@role='last-first'] or db:bibliomixed/db:bibliomset[1]/element()[1]/descendant::db:personname[1][@role='last-first'])">Not all of the biblio items have the same personname @role style [first-last=<value-of select="$first-last"/> / last-first=<value-of select="$last-first"/>], &check_id;</report>
</rule>
</pattern>
<pattern id="bibliography-style-2">
<title>Additional person name checks</title>
<rule context="db:personname" id="personname-context-2">
&precedingPageNoVariable;
<report test="db:surname and not(db:firstname) and not(db:honorific) and not(db:othername) and not(db:lineage)" role="warning" id="surname-only">It is very unusual for a name only to contain a surname (<value-of select="db:surname"/>). Is this correct? &check_ancestor; &pageNoAndChunkPDF;</report>
</rule>
</pattern>
<pattern id="biblio-other">
<title>More general biblio item tests</title>
<rule context="db:bibliomixed//db:title" id="bib-title-context-5">
&precedingPageNoVariable;
<report test="contains(., 'trans.')" role="warning" id="trans-in-title">Biblio item title contains the string 'trans.' which is almost certainly incorrect, &check_ancestor; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

	<pattern id='bibliography-checks-bibliomset'>
<title>bibliomset tests</title>
<rule context="db:bibliomset" id="bibliomset-context-3">
            <report test="db:bibliomset" id="nested-bibliomset">A bibliomset must not contain a bibliomset, &check_ancestor;</report>
</rule>
<rule context="db:bibliomixed" id="bib-context-7">
<report role='warning' test="count(db:bibliomset) = 1" id="single-bibliomset">A single bibliomset element in a reference suggests that part of the markup might be missing, or that it isn't required, &check_id;.</report>
<report role='warning' test="count(db:bibliomset) = 1 and db:bibliomset[@relation='journal'] and not(@role='serial')" id="bibliomset-journal">A single journal bibliomset element in a reference suggests it might need to be a bibliomixed{@role=serial], &check_id;.</report>
<report test="text()[contains(., ' in ') or contains(., 'In ')] and not(db:bibliomset)" role="warning" id="in-sans-bibliomset">"In" or "in" present in biblio item but no bibliomset. Is this a contribution or similar item?, &check_id;</report>
</rule>
	</pattern>
<pattern id="bibliography-checks-bibliomset-2">
<title>Ensure bibliomsets are in their correct bibliomised type</title>
<rule context="db:bibliomset[@relation='book']" id="bib-book-context">
<assert test="parent::db:bibliomixed[@role='contribution']" id="book-contribution">A 'book' bibliomset must be in a 'contribution' bibliomixed. Is the bibliomset wrong, or the bibliomixed[@role]? &check_ancestor;</assert>
<assert test="db:title" id="bibliomset-title">A bibliomset[@relation=book] should contain a title, &check_ancestor;</assert>
</rule>
<rule context="db:bibliomset[@relation='part']" id="bib-part-context-2">
<assert test="parent::db:bibliomixed[@role='contribution']" id="part-contribution">A 'part' bibliomset must be in a 'contribution' bibliomixed. Is the bibliomset wrong, or the bibliomixed[@role]? &check_ancestor;</assert>
<assert test="db:title" id="bibliomset-title3" role="warning">A bibliomset[@relation=part] should normally contain a title, &check_ancestor;</assert>
</rule>
<rule context="db:bibliomset[@relation='article']" id="bib-article-context-2">
<assert test="parent::db:bibliomixed[@role='article']" id="article-article-2">A 'article' bibliomset must be in a 'article' bibliomixed. Is the bibliomset wrong, or the bibliomixed[@role]? &check_ancestor;</assert>
<assert test="db:title" id="bibliomset-title4" role="warning">A bibliomset[@relation=article] should normally contain a title, &check_ancestor;</assert>
</rule>
<rule context="db:bibliomset[@relation='journal']" id="bib-journal-context">
<assert test="parent::db:bibliomixed[@role='article']" id="journal-article">A 'journal' bibliomset must be in a 'article' bibliomixed. Is the bibliomset wrong, or the bibliomixed[@role]? &check_ancestor;</assert>
<assert test="db:title" id="bibliomset-title2">A bibliomset[@relation=journal] should contain a title, &check_ancestor;</assert>
<report test="db:publishername or db:address" id="book-not-journal" role="warning">A journal should not normally contain a publishername or address. Is this really a bibliomixed[@role=contribution]?, &check_ancestor;</report>
</rule>
</pattern>

<pattern id="non-legal-biblio-checks">
<title>Biblio items that may or may not be legal ones</title>
<rule context="db:bibliomixed[not(@role='case' or @role='legislation')]" id="non-legal-context">
            <report test="db:bibliomisc[@role='legalRef']" id="legalref-present">This bibliomixed has a legalRef, but isn't a case or legislation &check_id;</report>
			<assert role='warning' test="descendant::db:title" id="non-legal-biblio-title">A bibliomixed should usually have a title &check_id;.</assert>
            <report role="warning" test="contains(., ' v ') or contains(., ' v. ') or contains(., ' vs ')" id="v-present">Biblio item contains "v", "v." or "vs", but is not a legal case; &check_id;</report>
            <report role="warning" test="contains(., 'Agreement') or contains(., 'Treaty') or contains(., 'Convention ') or contains(., 'Directive') or contains(., 'Declaration')" id="possible-legislation">Biblio item sub/title contains the word "Agreement", "Treaty", "Convention", "Directive" or "Declaration"; should this be an @role=legislation item? &check_id;</report>
</rule>
</pattern>

<pattern id="website-biblio-checks">
<title>Web sites in bibliographic items</title>
<rule context="db:bibliomixed[@role='website']" id="website-context">
			<assert test="descendant::db:uri" id="bibliomixed-website">A bibliomixed that is a website MUST contain a link/uri &check_id;.</assert>
</rule>
</pattern>

<pattern id="other-biblio-checks">
<title>General tests for bibliographic content</title>
        <rule context="db:bibliomixed[not(@role='case' or @role='legislation' or @role='series' or @role='serial' or @role='website' or @role='unpublished' or @role='other' or @role='recording' or @role='film')]" id="bib-o-context">
&precedingPageNoVariable;
            <report role="warning" test="not(db:bibliomset) and not(db:author|db:editor)" id="bibliomixed-author">It is very unusual not to have an author or editor in a biblio item. Is this correct? Is there an implied author? &check_id; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

<pattern id="bibliography-other">
<title>Tests for bibliomixed other and unpublished items</title>
<rule context="db:bibliomixed[@role='other']" id="bib-other-context">
<report test="text()[matches(., '‘.*’')]" id="bibliomixed-other-test" role="warning">Bibliomixed with @role=other contains untagged string ‘.*’. Is it an article or other bibliomixed @role type? &check_id; </report>
<report test="db:publishername or db:pubdate" id="bibliomixed-other-issue1">The bibliomixed with @role=other contains a publishername or pubdate, so should almost certainly be a monograph or contribution, &check_id;</report>
<report test="db:volumenum or db:issuenum" id="bibliomixed-other-issue2">The bibliomixed with @role=other contains a volumenum or issuenum, so should almost certainly be a journal article, &check_id;</report>
</rule>
<rule context="db:book[descendant::db:bibliomixed]" id="book-bib-context">
<!-- What proportion of bibliomixed are unpublished or other? A high proportion is suspicious -->
<let name="countMixed" value="count(descendant::db:bibliomixed)"/>
<let name="countUnpub" value="count(descendant::db:bibliomixed[@role='unpublished'])"/>
<let name="countOther" value="count(descendant::db:bibliomixed[@role='other'])"/>
<!-- This records the percentage and absolute numbers in information -->
<report role="information" test="$countUnpub + $countOther div $countMixed >0" id="proportion-unpub-other">Proportion of unpublished + other bibliomixed = <value-of select="($countUnpub + $countOther)*100 div $countMixed "/>%. countMixed = <value-of select="$countMixed"/>; countUnpub = <value-of select="$countUnpub"/>; countOther = <value-of select="$countOther"/>; </report>
<!-- This generates a warning if more than 5% are other or unpublished; may need to adjust the threshold -->
<report role="warning" test="($countUnpub + $countOther)*100 div $countMixed >5" id="proportion-unpublished-other">Proportion of unpublished + other bibliomixed = <value-of select="($countUnpub + $countOther)*100 div $countMixed " />%. It is likely that some of those items may be tagged incorrectly</report>
</rule>
</pattern>

<pattern id="bibliography-message">
<title>Tests for bibliographical items that are (email) messages</title>
<rule context="db:bibliomixed[@role='message']" id="message-context">
<report test="db:pubdate or db:edition or db:volumenum or db:issuenum or db:pagenums or db:publishername" id="biblio-message">The 'message' bibliomixed contains one or more elements that are not relevant for a message. Is the markup correct, or should the bibliomixed have a different @role? &check_id;</report>
</rule>
<rule context="db:bibliomixed[not(@role='message')]" id="not-message-context">
<report test="contains(., 'email') or contains(., 'Email')" role="warning" id="possible-message">A bibliomixed contains the word "email" but it does not have @role=message. Correct? &check_id;</report>
</rule>
</pattern>

<pattern id="bibliography-legal">
<title>Additional legal bibliographic item tests</title>
<rule context="db:book[descendant::db:bibliomixed]" id="book-bib-context-2">
<!-- What proportion of bibliomixed are cases or legislation? A high proportion is suspicious -->
<let name="countMixed" value="count(descendant::db:bibliomixed)"/>
<let name="countCase" value="count(descendant::db:bibliomixed[@role='case'])"/>
<let name="countLegislation" value="count(descendant::db:bibliomixed[@role='legislation'])"/>
<!-- This records the percentage and absolute numbers in information -->
<report role="information" test="$countCase + $countLegislation div $countMixed >0" id="proportion-case-leg">Proportion of cases + legislation bibliomixed = <value-of select="($countCase + $countLegislation)*100 div $countMixed "/>%. countMixed = <value-of select="$countMixed"/>; countCase = <value-of select="$countCase"/>; countLegislation = <value-of select="$countLegislation"/>; </report>
<!-- This generates a warning if more than 10% are case or legislation; may need to adjust the threshold -->
        <report role="warning" test="if (db:info/db:biblioid[@otherclass='legalContentType'] = 'cases') then 0 else (($countCase + $countLegislation)*100 div $countMixed >10)" id="proportion-case-legislation">Proportion of case + legislation bibliomixed = <value-of select="($countCase + $countLegislation)*100 div $countMixed " />%. It is likely that some of those items may be tagged incorrectly</report>
</rule>
</pattern>
        
        <pattern id="bibl-recordings">
                <title>Recordings</title>
                <rule context="db:bibliomixed[not(@role='recording')][not(ancestor::db:footnote)]" id="unmarked-recording">
                        <report test="ancestor::db:section[contains(db:info/db:title, 'Discograph') or contains(db:info/db:title, 'discograph') or contains(db:info/db:title, 'Recording') or contains(db:info/db:title, 'recording')]" id="poss-recording" role="warn"><name/> is in a section called 'Recordings' or 'Discography'; should <name/> have @role=recording? &check_id;</report>
                </rule>
                <rule context="db:bibliomixed[@role='recording']" id="bibl-recording">
                        <assert test="db:othercredit[@otherclass='artist']" id="artist-required" role="warn"><name/>[@role=recording] should probably contain the name of the artist in othercredit[@otherclass=artist] &check_id;</assert>
                        <assert test="db:title" id="recording-title" role="warn"><name/>[@role=recording] should probably contain a title &check_id;</assert>
                        <assert test="descendant::db:date" id="recording-date" role="warn"><name/>[@role=recording] should probably contain a date &check_id;</assert>
                </rule>
        </pattern>

        <pattern id="bibl-films">
                <title>Films</title>
                <rule context="db:bibliomixed[not(@role='film')][not(ancestor::db:footnote)]" id="unmarked-film">
                        <report test="ancestor::db:section[contains(db:info/db:title, 'Film') or contains(db:info/db:title, 'Video') or contains(db:info/db:title, 'film') or contains(db:info/db:title, 'video')]" id="poss-film" role="warn"><name/> is in a section called 'Films', 'Videos' or 'Filmography'; should <name/> have @role=film? &check_id;</report>
                </rule>
                <rule context="db:bibliomixed[@role='film']" id="bibl-film">
                        <assert test="db:title" id="film-title" role="warn"><name/>[@role=film] should probably contain a title &check_id;</assert>
                        <assert test="descendant::db:date" id="film-date" role="warn"><name/>[@role=film] should probably contain a date &check_id;</assert>
                </rule>
        </pattern>
        
        <pattern id="bibliolists-in-bibliodiv">
                <title>Bibliodivs should contain at least a bibliolist</title>
                <rule context="db:bibliodiv" id="bibliodiv-context">
                        <assert test="db:bibliolist" id="bibliodiv-bibliolist">A <name/> should contain a bibliolist.</assert>
                </rule>
        </pattern>
        
<pattern id="personname-checks">
<title>Name tests</title>
<rule context="db:author[not(ancestor::db:revision)]/db:personname|db:editor[not(ancestor::db:revision)]/db:personname|db:othercredit[not(ancestor::db:revision)]/db:personname" id="names-context">
<assert test="db:surname | db:firstname | db:othername" id="personname-components">A personname within author, editor or othercredit must contain name components, &check_ancestor;</assert>
<assert test="@role" id="personname-role-present">A personname within author, editor or othercredit must have an @role, &check_ancestor;</assert>
<report test="db:givenname" id="givenname-not-allowed">Use firstname instead of givenname, &check_ancestor;</report>
<report test="count(db:surname) &gt; 1" id="multiple-surnames">personname contains more than one surname, &check_ancestor;</report>
</rule>
<rule context="db:surname" id="surname-context-2">
&precedingPageNoVariable;
<report role="warning" test='matches(.,"&apos;s$")' id="surname-apos1">A surname ends with an apostrophe + s, which should probably be outside the surname element, though check against the source, &check_ancestor; &pageNoAndChunkPDF;</report>
<report role="warning" test='matches(.,"’s$")' id="surname-apos2">A surname ends with an apostrophe + s, which should probably be outside the surname element, &check_ancestor; &pageNoAndChunkPDF;</report>
</rule>
<rule context="db:author | db:editor" id="au-ed-context">
<report test="db:contrib" id="contrib-present">Element contrib must not be present in <name/>, use othercredit instead, &check_ancestor;</report>
</rule>
<rule context="db:info/db:othercredit | db:info/db:authorgroup/db:othercredit[1]" id="othercredit-context">
<assert test="db:contrib" id="contrib-required">Element othercredit in this position must contain contrib (see data spec), &check_ancestor;</assert>
<assert test="@class" id="othercredit-class-required">Element othercredit in info must have @class, &check_ancestor;</assert>
</rule>
<rule context="db:info/db:authorgroup/db:othercredit[position() gt 1]" id="othercredit-context-2">
<report test="db:contrib" id="multiple-othercredits-1">When othercredit occurs within authorgroup, only the first occurrence should have contrib. If a different contrib is required for one or more othercredits, group them separately, &check_ancestor;</report>
<assert test="string(@class) = string(parent::db:authorgroup/db:othercredit[1]/@class)" id="multiple-othercredits-2">When multiple othercredits are in an authorgroup they must all have the same @class, &check_ancestor;</assert>
</rule>
</pattern>


<pattern id="personname-checks2">
<title>Order of name components in personname</title>
<!-- need to handle occasions when lineage or honorific used as well -->
<rule context="db:personname[@role='last-first']" id="last-context">
<assert test="element()[1] = db:surname" id="last-first-1">A personname with @role=last-first needs to have a surname first &check_ancestor;</assert>
</rule>
<rule context="db:personname[@role='first-last'][not(db:lineage)]" id="first-context">
<assert test="db:surname and not(db:firstname[preceding-sibling::db:surname])" id="first-last-1" role="warning">A personname with @role=first-last should have a surname last &check_ancestor;</assert>
</rule>
<rule context="db:personname[@role='first-last'][db:lineage]" id="first-lineage-context">
<assert test="element()[last() -1] = db:surname" id="first-last-2" role="warning">There is a personname with @role=first-last and lineage; check that surname and lineage are in the correct sequence &check_ancestor;</assert>
</rule>
</pattern>

<pattern id="personname-checks3">
<title>Name components tests in bibliomixed</title>
<rule context="db:bibliomixed//db:firstname | db:bibliomixed//db:surname | db:bibliomixed//db:honorific | db:bibliomixed//db:othername | db:bibliomixed//db:lineage" id="name-context-3">
&precedingPageNoVariable;
<assert test="parent::db:personname" id="bibliomixed-name">A <name/> in a bibliomixed must be within a personname, &check_ancestor;</assert>
<report test="contains(.,'*') or contains(., '†') or contains(., '‡')" id="asterisk-in-name">A <name/> contains an asterisk/dagger or double dagger; This must be moved outside the element, and does it need to be a link? &check_ancestor; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

<pattern id="more-names">
<title>Other tests around names and contributors</title>
<rule context="db:othercredit[@role]" id="othercred-role-context">
<report test="not(@role='etal')" id="role-or-class">Othercredit has @role=<value-of select="@role"/>. Should this be a @class attribute instead? &ancestor_id;</report>
</rule>
</pattern>
  
<pattern id='bibliography-checks-accessed-date'>
<title>Accessed date</title>
<rule context="db:pubdate" id="pubdate-context">
<report role='error' test="@role='accessed'" id="accessed-date">The @role=accessed must be on a date element not a pubdate &check_ancestor;.</report>
</rule>
<rule context="db:bibliomixed" id="bib-context-5">
&precedingPageNoVariable;
<report role="warning" test="descendant::text()[contains(., 'accessed') or contains(., 'Accessed') or contains(., 'retrieved') or contains(., 'Retrieved')][not(following-sibling::db:date)]" id="possible-access-date">Biblio item contains the word "accessed" or "retrieved" but it is not followed by a date, &check_id; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

<pattern id="uri">
<title>Incorrectly marked up URIs and DOIs</title>
<rule context="db:link[@xlink:href][contains(., 'http:')] | db:link[@xlink:href][contains(., 'www')] | db:link[@xlink:href][contains(., '/')]" id="link-context-5">
<assert test="db:uri or matches(., '10\.\d\d\d\d/')" id="external-link-content">External links must contain a uri element or be a DOI string &check_ancestor;</assert>
</rule>
<!-- Extend this to include .com, .edu etc? Not sure this is a fool-proof way of testing this-->
        <rule context="db:para//text()[contains(., 'http:')] | db:para//text()[contains(., 'www.')] | db:bibliomixed//text()[contains(., 'http:')] | db:bibliomixed//text()[contains(., 'www.')]" id="para-link-context">
                <assert test="parent::db:uri" id="untagged-url"><name path="parent::node()"/> contains a URL but is not properly marked up; should be in link/uri elements &check_ancestor;</assert>
        </rule>

<rule context="db:uri" id="uri-context">
&precedingPageNoVariable;
<report test="contains(., ' ')" id="uri-spaces">A uri element must not contain spaces, &check_ancestor; &pageNoAndChunkPDF;</report>
<assert test="if (ancestor::db:para or ancestor::db:bibliomixed or ancestor::db:address or ancestor::db:phrase) then (parent::db:link) else 1" id="uri-in-link">A <name/> must be in a link element, &check_ancestor;</assert>
</rule>
</pattern>

<pattern id="untagged-dois">
<title>Untagged DOIs</title>
<rule context="text()[not(parent::db:uri) and not(parent::db:link) and not(parent::db:biblioid)]" id="untagged-doi-context">
&precedingPageNoVariable;
<report test="matches(., '10\.\d\d\d\d/')" id="untagged-doi">There is an untagged DOI in &check_ancestor; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

<pattern id="uri-testing">
<title>URI tests</title>
<!-- hrefs on author, editor + othercredit are not URLs -->
        <rule context="db:link[@xlink:href][not(@role='relative') and not(@xlink:role='http://www.oxfordartonline.com/subscriber/article/grove/art/')]" id="href-context">
<assert test="@xlink:href[matches(., '^[a-zA-Z]+://[a-zA-Z0-9\-]+:?[a-zA-Z0-9\-]+\.?[a-zA-Z0-9\-]+\.') or matches(., '^mailto:')]" id="uri-check" role="warning">@xlink:href may not be a valid URI. Does it start with http:// or https://? [if it is a relative path, it may need @role], &check_ancestor;</assert>
<!-- Not sure castable as works -->
<assert test="@xlink:href castable as xs:anyURI" id="broken-uri">Broken URI in @xlink:href, &check_ancestor;</assert>
</rule>
<rule context="db:link[@xlink:href][@role='relative']" id="relative-uri-tests">
<assert test="substring-before(@xlink:href, '/') = ('media', 'images', 'pdfs')" id="relative-link-dir">A relative link target must start with one of the local directories (media, images, pdfs), &check_ancestor;</assert>
</rule>
<rule context="db:author[@xlink:href] | db:editor[@xlink:href] | db:othercredit[@xlink:href]" id="au-link-context">
<assert id="biblio-id-present" test="@xlink:role='biblioAuID'"><name/> element with an @href must have @xlink:role=biblioAuID, &check_ancestor;</assert>
<assert test="matches(@xlink:href, '^Con[0-9]+') or matches(@xlink:href, '^B[0-9]+') or matches(@xlink:href, '^C[0-9]+') or matches(@xlink:href, '^[0-9]+')" id="biblio-id-format">The biblioAuID in <name/>/@xlink:href is not valid, &check_ancestor;</assert>
</rule>
</pattern>

<pattern id="uri-testing-2">
<title>Empty href test</title>
<rule context="*[@xlink:href]" id="all-href-context">
<assert test="normalize-space(@xlink:href)" id="empty-href">@xlink:href is given with no value, &check_ancestor;</assert>
</rule>
</pattern>

<pattern id="uri-testing-3">
<rule context="db:link[matches(., '^10\.\d\d\d\d/')]" id="doi-link-context">
<assert test="starts-with(@xlink:href, 'http://dx.doi.org/')" id="doi-href">The @href of a 'raw' DOI must include the http://dx.doi.org/ prefix, &check_ancestor;</assert>
</rule>
</pattern>
        
        <pattern id="anchors">
                <title>Anchors</title>
                <rule context="db:anchor" id="anchor">
                        <assert test="@role='objectPointer'" id="anchor-role">An <name/> must have @xlink:role=objectPointer, &check_id;</assert>
                        <assert test="@xml:id" id="anchor-id">An <name/> must have an @xml:id, &check_ancestor;</assert>
                        <assert test="key('objectTarget-ids', @xml:id)" id="object-target-id">A <name/> must point to an element[@xlink:role=objectPointer], &check_id;</assert>
                </rule>
        </pattern>

<pattern id="xlink-testing-1">
<title>hrefs only allowed on link, author, editor, othercredit, keyword etc</title>
        <rule context="*[not(self::db:author or self::db:editor or self::db:othercredit or self::db:link or self::db:keyword or self::db:article or self::db:figure or self::db:informalfigure or self::db:table or self::db:informaltable or self::db:sidebar)]" id="href-other-context">
<report test="@xlink:href" id="impermissible-href-location">@xlink:href is on a <name/> element, which is not allowed, &check_ancestor;</report>
</rule>
        <rule context="db:figure[@xlink:href] | db:informalfigure[@xlink:href] | db:table[@xlink:href] | db:informaltable[@xlink:href] | db:sidebar[@xlink:href]" id="object-context1">
                <assert test="@xlink:role='objectPointer'" id="object-role">A <name/> with @xlink:href must have "@xlink:role='objectPointer', &check_id;</assert>
                <assert test="key('objectPointer-ids', @xlink:href)" id="object-id">A <name/> with @xlink:href must point to an anchor[@role=objectPointer], &check_id;</assert>
        </rule>
        <rule context="db:figure[not(@xlink:href)][ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '5']] | db:informalfigure[not(@xlink:href)][ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '5']] | db:table[not(@xlink:href)][ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '5']] | db:informaltable[not(@xlink:href)][ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '5']] | db:sidebar[not(@xlink:href)][ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '5']]" id="object-context3">
                <report test="parent::db:para" id="object-in-para">A <name/> occurs within a para, which is not allowed; check if it should be an inlinemediaobject, or most likely should be moved after the para and add an anchor to show original location, &check_id;</report>
        </rule>
</pattern>
        
        <pattern id="object-testing">
                <title>Additional tests for object location</title>
                <rule context="db:figure[ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '5']] | db:informalfigure[ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '5']] | db:table[ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '5']] | db:informaltable[ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '5']] | db:sidebar[ancestor::db:book[db:info/db:biblioid[@otherclass='schematronVersion'] ge '5']]" id="object-context4">
                        <report test="(parent::db:blockquote or parent::db:epigraph) and (preceding-sibling::db:attribution or following-sibling::db:para[@role='right'])" id="object-in-blockquote" role="warning">A <name/> occurs within a <name path="parent::node()"/>, which also contains an attribution or para[@role=right], so this object should probably be moved after the <name path="parent::node()"/>, &check_id;</report>
                </rule>
        </pattern>

<pattern id="xlink-testing-2">
<title>xlink:role only available on author, keyword or title elements etc</title>
        <rule context="*[not(self::db:author or self::db:editor or self::db:othercredit or self::db:keyword or self::db:article or self::db:link or self::db:figure or self::db:informalfigure or self::db:table or self::db:informaltable or self::db:sidebar or self::db:person)]" id="xlink-role-context">
<report test="@xlink:role" id="impermissible-xlink-role">@xlink:role is on a <name/> element, which is not allowed, &check_ancestor;</report>
</rule>
        <rule context="db:figure[@xlink:role] | db:informalfigure[@xlink:role] | db:table[@xlink:role] | db:informaltable[@xlink:role] | db:sidebar[@xlink:role]" id="object-context2">
                <assert test="@xlink:href" id="object-href">A <name/> with @xlink:role must have "@xlink:href, &check_id;</assert>
        </rule>
</pattern>

<pattern id="xlink-testing-2a">
<title>xlink:label only available on specific elements</title>
        <rule context="*[not(self::db:article) and not(self::db:biblioid)]" id="xlink-role-context-2">
<report test="@xlink:label" id="impermissible-xlink-label">@xlink:label is is on a <name/> element, which is not allowed, &check_ancestor;</report>
</rule>
<rule context="db:article[@xlink:label]" id="article-xlink">
<assert test="@xlink:label = 'otherBook'" id="article-xlink-label">The value of @xlink:label on <name/> must be 'otherBook', &check_id;</assert>
</rule>
</pattern>

<pattern id="xlink-testing-3">
<title>Other xlink attributes not allowed anywhere</title>
<rule context="*" id="global-xlink-context">
<report test="@xlink:arcrole" id="impermissible-xlink-arcrole">@xlink:arcrole is is on a <name/> element, which is not allowed, &check_ancestor;</report>
<report test="@xlink:title" id="impermissible-xlink-title">@xlink:title is is on a <name/> element, which is not allowed, &check_ancestor;</report>
<report test="@xlink:show" id="impermissible-xlink-show">@xlink:show is is on a <name/> element, which is not allowed, &check_ancestor;</report>
<report test="@xlink:actuate" id="impermissible-xlink-actuate">@xlink:actuate is is on a <name/> element, which is not allowed, &check_ancestor;</report>
<report test="@xlink:from" id="impermissible-xlink-from">@xlink:from is is on a <name/> element, which is not allowed, &check_ancestor;</report>
<report test="@xlink:to" id="impermissible-xlink-to">@xlink:to is is on a <name/> element, which is not allowed, &check_ancestor;</report>
</rule>
</pattern>

<pattern id="email-tests">
<title>Email addresses</title>
<rule context="db:link[@xlink:href][matches(., '[a-zA-Z0-9]@[a-zA-Z0-9]')]" id="email-context">
<assert test="db:email" id="email-test-1" role="warning">Email addresses must have their content in an email element &check_ancestor;</assert>
<assert test="@xlink:href[matches(., '^mailto:[a-zA-Z0-9\-\._]+@[a-zA-Z0-9\-_]+\.[a-zA-Z0-9\-]+')]" id="email-test-2" role="warning">The @xlink:href contains an @ symbol, suggesting it miht be an email address if so it should start with 'mailto:' and be followed by a correctly-construccted email address, &check_ancestor;</assert>
</rule>
<rule context="text()[matches(., '\w@\w')]" id="email-context-2">
<assert test="ancestor::db:link/db:email" role="warning" id="email-test-3"><name/> contains an @ symbol; is it an email address that is not properly marked up? &check_id;</assert>
</rule>
<rule context="db:email" id="email-context-3">
<assert test="parent::db:link[@xlink:href]" id="email-test-4">email element is not within a link &check_ancestor;</assert>
</rule>
</pattern>

<!-- address component tests -->
<pattern id="addresses">
<title>Address components</title>
<rule context="db:address/element()[not(self::db:country)]" id="country-context">
<report id="country-name-test" test='text()="Afghanistan" or text()="Åland Islands" or text()="Aland Islands" or text()="Albania" or text()="Algeria" or text()="American Samoa" or text()="Andorra" or text()="Angola" or text()="Anguilla" or text()="Antarctica" or text()="Antigua and Barbuda" or text()="Argentina" or text()="Armenia" or text()="Aruba" or text()="Australia" or text()="Austria" or text()="Azerbaijan" or text()="Bahamas" or text()="Bahrain" or text()="Bangladesh" or text()="Barbados" or text()="Belarus" or text()="Belgium" or text()="Belize" or text()="Benin" or text()="Bermuda" or text()="Bhutan" or text()="Bolivia" or text()="Bosnia and Herzegovina" or text()="Botswana" or text()="Brazil" or text()="Brunei Darussalam" or text()="Bulgaria" or text()="Burkina Faso" or text()="Burundi" or text()="Cambodia" or text()="Cameroon" or text()="Canada" or text()="Cape Verde" or text()="Cayman Islands" or text()="Central African Republic" or text()="Chad" or text()="Chile" or text()="China" or text()="Christmas Island" or text()="Colombia" or text()="Comoros" or text()="Congo" or text()="Congo, the Democratic Republic of the" or text()="Cook Islands" or text()="Costa Rica" or text()="Côte d&apos;Ivoire" or text()="Ivory Coast" or text()="Croatia" or text()="Cuba" or text()="Curaçao" or text()="Curacao" or text()="Cyprus" or text()="Czech Republic" or text()="Denmark" or text()="Djibouti" or text()="Dominica" or text()="Dominican Republic" or text()="Ecuador" or text()="Egypt" or text()="El Salvador" or text()="Equatorial Guinea" or text()="Eritrea" or text()="Estonia" or text()="Ethiopia" or text()="Falkland Islands" or text()="Faroe Islands" or text()="Fiji" or text()="Finland" or text()="France" or text()="French Guiana" or text()="French Polynesia" or text()="Gabon" or text()="Gambia" or text()="Georgia" or text()="Germany" or text()="Ghana" or text()="Gibraltar" or text()="Greece" or text()="Greenland" or text()="Grenada" or text()="Guadeloupe" or text()="Guam" or text()="Guatemala" or text()="Guernsey" or text()="Guinea" or text()="Guinea-Bissau" or text()="Guyana" or text()="Haiti" or text()="Heard Island and McDonald Islands" or text()="Holy See" or text()="Vatican City" or text()="Honduras" or text()="Hong Kong" or text()="Hungary" or text()="Iceland" or text()="India" or text()="Indonesia" or text()="Iran" or text()="Iraq" or text()="Ireland" or text()="Isle of Man" or text()="Israel" or text()="Italy" or text()="Jamaica" or text()="Japan" or text()="Jersey" or text()="Jordan" or text()="Kazakhstan" or text()="Kenya" or text()="Kiribati" or text()="North Korea" or text()="South Korea" or text()="Korea" or text()="Kuwait" or text()="Kyrgyzstan" or text()="Laos" or text()="Latvia" or text()="Lebanon" or text()="Lesotho" or text()="Liberia" or text()="Libya" or text()="Liechtenstein" or text()="Lithuania" or text()="Luxembourg" or text()="Macao" or text()="Macedonia" or text()="Madagascar" or text()="Malawi" or text()="Malaysia" or text()="Maldives" or text()="Mali" or text()="Malta" or text()="Marshall Islands" or text()="Martinique" or text()="Mauritania" or text()="Mauritius" or text()="Mayotte" or text()="Mexico" or text()="Federated States of Micronesia" or text()="Moldova" or text()="Monaco" or text()="Mongolia" or text()="Montenegro" or text()="Montserrat" or text()="Morocco" or text()="Mozambique" or text()="Myanmar" or text()="Namibia" or text()="Nauru" or text()="Nepal" or text()="Netherlands" or text()="New Caledonia" or text()="New Zealand" or text()="Nicaragua" or text()="Niger" or text()="Nigeria" or text()="Niue" or text()="Norfolk Island" or text()="Northern Mariana Islands" or text()="Norway" or text()="Oman" or text()="Pakistan" or text()="Palau" or text()="Palestine" or text()="Panama" or text()="Papua New Guinea" or text()="Paraguay" or text()="Peru" or text()="Philippines" or text()="Pitcairn" or text()="Poland" or text()="Portugal" or text()="Puerto Rico" or text()="Qatar" or text()="Réunion" or text()="Romania" or text()="Russian Federation" or text()="Rwanda" or text()="Saint Barthélemy" or text()="Saint Helena, Ascension and Tristan da Cunha" or text()="Saint Kitts and Nevis" or text()="Saint Lucia" or text()="Saint Pierre and Miquelon" or text()="Saint Vincent and the Grenadines" or text()="Samoa" or text()="San Marino" or text()="Sao Tome and Principe" or text()="Saudi Arabia" or text()="Senegal" or text()="Serbia" or text()="Seychelles" or text()="Sierra Leone" or text()="Singapore" or text()="Slovakia" or text()="Slovenia" or text()="Solomon Islands" or text()="Somalia" or text()="South Africa" or text()="South Georgia and the South Sandwich Islands" or text()="South Sudan" or text()="Spain" or text()="Sri Lanka" or text()="Sudan" or text()="Suriname" or text()="Svalbard and Jan Mayen" or text()="Swaziland" or text()="Sweden" or text()="Switzerland" or text()="Syrian Arab Republic" or text()="Taiwan" or text()="Tajikistan" or text()="Tanzania, United Republic of" or text()="Thailand" or text()="Timor-Leste" or text()="East Timor" or text()="Togo" or text()="Tokelau" or text()="Tonga" or text()="Trinidad and Tobago" or text()="Tunisia" or text()="Turkey" or text()="Turkmenistan" or text()="Turks and Caicos Islands" or text()="Tuvalu" or text()="Uganda" or text()="Ukraine" or text()="United Arab Emirates" or text()="United Kingdom" or text()="England" or text()="Scotland" or text()="Wales" or text()="Northern Ireland" or text()="Great Britain" or text()="UK" or text()="GB" or text()="United States" or text()="USA" or text()="United States Minor Outlying Islands" or text()="Uruguay" or text()="Uzbekistan" or text()="Vanuatu" or text()="Venezuela" or text()="Viet Nam" or text()="Vietnam" or text()="British Virgin Islands" or text()="US Virgin Islands" or text()="Wallis and Futuna" or text()="Western Sahara" or text()="Yemen" or text()="Zambia" or text()="Zimbabwe"'>Address component contains a country name but it is not in a "country" element; &check_ancestor;</report>
</rule>
</pattern>


	<!-- TABLE CHECKS. Multiple patterns because we need multiple rules matching various elements + attributes -->
	<pattern id='table-checks-1'>
<title>Tables</title>
<!-- BS added morerows handling; this just excludes any rows that might be affected by column or row spans, so we'll need to add other tests to ensure that those rows are right too -->
<rule context="db:table | db:informaltable" id="tables-context">
<report test="@xml:id" role="information" id="table-present">There is a <name/>, &check_id;</report>
</rule>
<rule context='db:row[not(*/@namest or */@spanspec or */@spanname or preceding-sibling::db:row/*/@morerows)]' id="row-context">
<assert role='warning' id='row-cols-count' test="count(db:entry) = ancestor::db:tgroup/@cols">The number of columns in a table row must equal the number declared on the "tgroup" element; &check_id;.</assert>
</rule>
<rule context="db:entry" id="entry-context">
<report test="@morerows or @namest or @spanspec or @spanname" id="table-row-col-att" role="information">Table entry has row/col spans, &check_id;</report>
</rule>
</pattern>
	
	<pattern id='table-checks-2'>
<title>Tables 2</title>
<rule context='db:entry[@namest]' id="namest-context">
<!-- if an entry mentions a start row, there must be a colspec that matches the name. -->
<assert test="ancestor::db:tgroup/db:colspec[@colname=current()/@namest]" id="namest-present">The &named_element_with_id; must refer to a "colspec" element by name.</assert>
</rule>
	</pattern>

	<pattern id='table-checks-colnums'>
<title>Tables, including column counting</title>
<rule context='db:entry[@nameend]' id="nameend-context">
<let name='start-name' value='@namest'/>
<let name='end-name' value='@nameend'/>
<let name='start-colspec' value='ancestor::db:tgroup[1]/db:colspec[@colname = $start-name]'/>
<let name='end-colspec' value='ancestor::db:tgroup[1]/db:colspec[@colname = $end-name]'/>
<let name='start-colspec-pos' value='index-of((ancestor::db:tgroup[1]/db:colspec/@colname), $start-name)'/>
<let name='end-colspec-pos' value='index-of((ancestor::db:tgroup[1]/db:colspec/@colname), $end-name)'/>
<let name='start-num' value="if ($start-colspec/@colnum) then $start-colspec/@colnum else $start-colspec-pos"/>
<let name='end-num' value="if ($end-colspec/@colnum) then $end-colspec/@colnum else $end-colspec-pos"/>
<!-- if an entry mentions an end row, there must be a colspec that matches the name. -->
<assert test="ancestor::db:tgroup[1]/db:colspec[@colname=current()/@nameend]" id="nameend-present">The &named_element_with_id; must refer to a "colspec" element by name.</assert>
<assert test="@namest" id="namest-and-end">The &named_element_with_id; has a "nameend" attribute. It must also have a "namest" attribute.</assert>
<assert test="$end-num - $start-num > 0" id="col-span-test">The &named_element_with_id; must occupy at least one column.</assert>
</rule>
	</pattern>
	
	<pattern id='table-checks-3'>
<title>Table attributes</title>
<rule context='db:entry[@nameend]' id="nameend-context-2">
<!-- if an entry mentions an end row, there must be a colspec that matches the name. -->
<assert test="ancestor::db:tgroup/db:colspec[@colname=current()/@nameend]" id="nameend-present-2">The &named_element_with_id; must refer to a "colspec" element by name.</assert>
<assert test="@namest" id="namest-required">The &named_element_with_id; has a "nameend" attribute. It must also have a "namest" attribute.</assert>
</rule>
	</pattern>

<!-- Equations -->
<pattern id="equations">
<title>Tests for equations</title>
<rule context="db:equation | db:informalequation | db:inlineequation" id="eqns-context">
<report test="self::*" id="eqn-present" role="information">An <name/> is present containing <value-of select="child::*/local-name()"/>,  &check_id;</report>
<report id="eqn-condition-required" test="(db:mediaobject or db:inlinemediaobject or mml:math) and not(@condition)" role="warning"><name/> contains: <value-of select="child::*/local-name()"/>, but does not have @condition, &check_id;</report>
</rule>
</pattern>

<pattern id="equations2">
<title>Tests for equations</title>
<!-- There might be a more elegant way of writing this to combine all three elements into one rule, but this works-->
<rule context="db:equation" id="equation-context">
<report id="missing-eqn-sibling-1" test="@condition='mathml' and not(preceding-sibling::element()[1][self::db:equation[@condition='non-mathml']] or following-sibling::element()[1][self::db:equation[@condition='non-mathml']])">An <name/> is present with @condition=<value-of select="@condition"/> but does not have a non-mathml sibling, &check_id;</report>
<report id="missing-eqn-sibling-2" test="@condition='non-mathml' and not(preceding-sibling::element()[1][self::db:equation[@condition='mathml']] or following-sibling::element()[1][self::db:equation[@condition='mathml']])">An <name/> is present with @condition=<value-of select="@condition"/> but does not have a mathml sibling, &check_id;</report>
</rule>
<rule context="db:informalequation" id="infeqn-context">
<report id="missing-infeqn-sibling-1" test="@condition='mathml' and not(preceding-sibling::element()[1][self::db:informalequation[@condition='non-mathml']] or following-sibling::element()[1][self::db:informalequation[@condition='non-mathml']])">An <name/> is present with @condition=<value-of select="@condition"/> but does not have a non-mathml sibling, &check_id;</report>
<report id="missing-infeqn-sibling-2" test="@condition='non-mathml' and not(preceding-sibling::element()[1][self::db:informalequation[@condition='mathml']] or following-sibling::element()[1][self::db:informalequation[@condition='mathml']])">An <name/> is present with @condition=<value-of select="@condition"/> but does not have a mathml sibling, &check_id;</report>
</rule>
<rule context="db:inlineequation" id="inlineeqn-context">
<report id="missing-ileqn-sibling-1" test="@condition='mathml' and not(preceding-sibling::element()[1][self::db:inlineequation[@condition='non-mathml']] or following-sibling::element()[1][self::db:inlineequation[@condition='non-mathml']])">An <name/> is present with @condition=<value-of select="@condition"/> but does not have a non-mathml sibling, &check_id;</report>
<report id="missing-ileqn-sibling-2" test="@condition='non-mathml' and not(preceding-sibling::db:inlineequation[@condition='mathml'] or following-sibling::db:inlineequation[@condition='mathml'])">An <name/> is present with @condition=<value-of select="@condition"/> but does not have a mathml sibling, &check_id;</report>
</rule>
</pattern>

<pattern id="equations-2">
<title>Additional equation tests</title>
<rule context="db:equation/db:mediaobject | db:informalequation/db:mediaobject | db:inlineequation/db:inlinemediaobject" id="eqns-context-2">
<assert id="multi-format-eqns" test="db:imageobject/db:imagedata[@outputformat='web'] and db:imageobject/db:imagedata[@outputformat='print']">Equations as images need both web and print versions, &check_ancestor;</assert>
</rule>
<rule context="db:inlineequation/mml:math" id="mml-context">
<assert test="@display='inline'" id="inline-math-attribute">MathML within an inlineequation must have @display=inline, &check_ancestor;</assert>
</rule>
</pattern>

<pattern id="equation-condition-attributes">
<title>A @condition attribute is only allowed on specific elements, where they must take the values defined in the schema. If a @condition is included on any other element it is an error</title>
<rule context="*[@condition='mathml' or @condition='non-mathml']" id="math-cond-context">
<report test="not(local-name() = $elements-with-math-condition )" id="math-condition-attribute">The <name/> element has a @condition attribute, but it is not a defined value in the schema. &check_id;</report>
</rule>
</pattern>

<!--<pattern id="qanda">
<title>Q and A set tests</title>
<rule context="db:para/node()[1][self::db:emphasis[string-length(.) lt 50]]">
<report role="warning" id="possible-qandaset" test="parent::db:para/following-sibling::db:para[1]/node()[1][self::db:emphasis[string-length(.) lt 50]]">A para beginning with emphasis is followed by the same. Could it be a qandaset? &check_ancestor;</report>
</rule>
</pattern>-->

<pattern id="sidebar">
<title>Sidebars</title>
<rule context="db:sidebar" id="sidebar-context">
&precedingPageNoVariable;
<report test="." role="information" id="sidebar-present">A sidebar is present (@role=<value-of select="@role"/>), &check_id; &pageNoAndChunkPDF;</report>
<report test="@role = ('sidebar4', 'sidebar5', 'sidebar6', 'sidebar7', 'sidebar8', 'sidebar9')" role="warning" id="exceptional-sidebar-roles">Element <name/> with role '<value-of select="@role"/>' should only be used in exceptional cases</report>        
</rule>
</pattern>

	<!-- index terms -->
	<pattern id="index-checks">
<title>Indexes and index terms</title>
        <rule context="db:book" id="book-index-context">
            <report id="index-missing" test="descendant::db:indexterm and not(descendant::db:index)">Book contains indexterms but no "index" element, &check_id;</report>
            <report id="indexterms-missing" test="@role='fullText' and descendant::db:index[not(db:variablelist)] and not(descendant::db:indexterm)">Book contains an "index" but no indexterms, &check_id;</report>
        </rule>
        <rule context="db:index[ancestor::db:book[count(descendant::db:index) > 1]] | db:indexterm[not(@class='endofrange')][ancestor::db:book[count(descendant::db:index) > 1]]" id="index-type-context">
            <assert test="@type" id="missing-index-type">If a book has more than one index, all <name/> MUST have @type, &check_id;</assert>
        </rule>
		<rule context="db:title" id="title-ind-context">
			<assert test="not(db:indexterm)" id="indexterm-in-title">The title attribute with id "<value-of select="@xml:id"/>" contains indexterm elements. These should be contained in a separate itermset element.</assert> 
		</rule>
		<rule context="db:itermset" id="itermset-context">
			<assert role='error' test="not(db:indexterm[@class='startofrange'])" id="itermset-with-range">The indexterm with id "<value-of select="@xml:id"/>" starts a range inside an itermset. This cannot be correct.</assert>
		</rule>
			</pattern>

<pattern id="index-1a">
<title>Index term tests</title>
		<rule context="db:indexterm[@class='startofrange']" id="startrange-context">
			<let name="current-id" value="@xml:id"/>
			<assert role='error' test="not(preceding::db:indexterm[@startref='$current-id'])" id="end-before-start">The indexterm with id "<value-of select="@xml:id"/>" starts a range, the end of range occurs before it.</assert>
			<assert role='error' test="//db:indexterm[@startref=$current-id]" id="no-end-range">The indexterm with id "<value-of select="@xml:id"/>" starts a range but there is no end of range marker.</assert>
			<assert role="error" test="not(ancestor::db:footnote)" id="range-in-footnote-1">The indexterm with id "<value-of select="@xml:id"/>" starts a range but is a child of a footnote. This cannot occur.</assert>
		</rule>
		<rule context="db:indexterm[@class='endofrange']" id="endrange-context">
			<let name="current-id" value="@xml:id"/>
			<assert role="error" test="not(ancestor::db:footnote)" id="range-in-footnote-2">The indexterm with startref "<value-of select="@startref"/>" ends a range but is a child of a footnote. This cannot occur.</assert>
            <report test="@type" id="type-endofrange">The <name/> with id=<value-of select="$current-id"/> has a @type attribute, which is not required when @class=endofrange</report>
		</rule>
</pattern>

<pattern id="index-2">
<title>Index term tests</title>
<rule context="db:indexterm[@type]" id="indexterm-type-context">
<assert test="key('indextype', @type)" id="wrong-index-type">Index term @type (= <value-of select="@type"/>) does not match an index, &check_id;</assert>
</rule>
</pattern>	

<pattern id="index-3">
<title>Further index term tests</title>
<let name="permissible-indexterm-locations" value="('attribution', 'emphasis', 'entry', 'itermset', 'line', 'member', 'para', 'index')"/>
<rule context="db:indexterm" id="indexterm-context">
<assert test="parent::node()[local-name() = $permissible-indexterm-locations]" id="indexterm-location">The <name/> element is within a <name path="parent::node()"/>, which is not allowed. &check_id;</assert>
<report test="@zone" id="zone-present">The @zone attribute is not to be used; use the @class attribute instead. &check_id;</report>
<assert test="@class" id="indexterm-class-missing">The @class on indexterm is required. &check_id;</assert>
<report test="ancestor::db:abstract" id="abstract-indexterm">An indexterm is not permitted in an <name/>, &check_id;</report>
</rule>
<rule context="db:index" id="index-context">
<report test="db:indexterm" id="index-with-terms" role="information">The index is captured as back-of-book content not as inline terms and contains <value-of select="count(db:indexterm)"/> indexterms. &check_id;</report>
<assert test="parent::db:part[@role='back']" id="index-not-back">An <name/> must be within part[@role=back], &check_id;</assert>
</rule>
</pattern>

<pattern id="index-4">
<title>'See' index tests</title> <!-- db:indexterm[db:see]/db:primary
	<xsl:key name="indexsee-primary" match="db:indexterm[db:see][not(db:secondary or db:tertiary)]/db:primary" use="text()"/> 
	<xsl:key name="indexsee-secondary" match="db:indexterm[db:see][not(db:primary or db:tertiary)]/db:secondary" use="text()"/> 
	<xsl:key name="indexsee-tertiary" match="db:indexterm[db:see][not(db:secondary or db:primary)]/db:tertiary" use="text()"/> 
 -->
<rule context="db:indexterm[not(db:see)][not(db:secondary or db:tertiary)]" id="indexterm-context-2">
<report test="key('indexsee-primary',db:primary)" id="see-mismatch">Index term matches a 'see' primary term, which is incorrect ("<value-of select="db:primary"/>"), &check_id;</report>
</rule>
<rule context="db:indexterm[not(db:see)][not(db:primary or db:tertiary)]" id="indexterm-context-3">
<report test="key('indexsee-secondary',db:secondary)" id="see-mismatch2">Index term matches a 'see' secondary term, which is incorrect ("<value-of select="db:secondary"/>"), &check_id;</report>
</rule>
<rule context="db:indexterm[not(db:see)][not(db:secondary or db:primary)]" id="indexterm-context-4">
<report test="key('indexsee-tertiary',db:tertiary)" id="see-mismatch3">Index term matches a 'see' tertiary term, which is incorrect ("<value-of select="db:tertiary"/>"), &check_id;</report>
</rule>
<rule context="db:indexterm[db:see]" id="see-context-4">
<assert test="parent::db:itermset" id="see-in-itermset">Index terms containing 'see' must be within an itermset in the chunk info, &check_id;</assert>
</rule>
<rule context="db:see | db:seealso" id="see-context-2">
<assert test="key('primary', .)" id="see-seealso-target" role="warning">The '<name/>' element doesn't have a completely matching primary index term ("<value-of select="."/>"), &check_ancestor;</assert>
</rule>
</pattern>
        
<pattern id="index-components">
<title>Tests for elements within indexterm</title>
<rule context="db:primary | db:secondary | db:tertiary" id="index-component-context">
<report test="ends-with(., ':')" id="index-component-test">A <name/> must not end with a colon, &check_ancestor;</report>
</rule>
</pattern>


	<!-- MARKUP CHECKS -->
	<!-- emphasis -->
	<pattern id='emphasis-checks'>
<title>Use of the emphasis element</title>
		<rule context="db:emphasis" id="emphasis-context">
&precedingPageNoVariable;
			<report test="@role ='superscript' or @role='sup'" id="superscript">Use the "superscript" element instead of an emphasis role; &check_ancestor;</report>
			<report test="@role ='subscript' or @role='sub'" id="subscript">Use the "subscript" element instead of an emphasis role; &check_ancestor;</report>
            <report role="information" test="@role='smaller' or @role='larger' or @role='sans-serif' or @role='serif'" id="rare-emph-present">An emphasis element has the @role value "<value-of select="@role"/>", &check_ancestor; &pageNoAndChunkPDF;</report>
		</rule>
	</pattern>

<pattern id="condition-attributes">
<title>A @condition attribute is only allowed on the defined list of elements, where they must take the values defined in the schema. If a @condition is included on any other element it is an error</title>
<!-- Add test to ensure that correct condition value is on the right elements -->
<let name="elements-with-condition" value="('author', 'bibliomset', 'editor', 'equation', 'glossterm', 'informalequation', 'inlineequation', 'inlinemediaobject', 'phrase', 'pubdate', 'remark', 'title')"/>
<rule context="*[@condition]" id="condition-context">
<report test="not(local-name() = $elements-with-condition )" id="test-condition-attribute">The <name/> element has a @condition attribute, but it is not one of the elements which is allowed to have it. &check_id;</report>
<report test="not(self::db:remark)" id="condition-present" role="information">A @condition attribute with value = '<value-of select="@condition"/>' is present, &check_ancestor;</report>
</rule>
</pattern>

<pattern id="condition-attributes-2">
<rule context="*[@condition='display']" id="display-context">
<assert test="following-sibling::*[@condition='hidden'] or preceding-sibling::*[@condition='hidden']" id="display-item-but-no-hidden-sibling">The <name/> element has @condition=display but has no sibling hidden element, &check_ancestor;</assert>
</rule>
</pattern>


<pattern id="processing-instructions-A">
<rule context="processing-instruction()" id="processing-instruction">
<let name="PI-types" value="('page', 'break', 'insert')"/>
<assert test="parent::node()[processing-instruction(page) or processing-instruction(insert) or processing-instruction(oxygen) or processing-instruction(break) or processing-instruction(dbhtml) or processing-instruction(dbfo)]" id="invalid-pi">Invalid processing instruction (only page | insert | break | dbhtml | dbfo | oxygen are permitted) [<value-of select="."/>]</assert>
        <report test="name() = ('page', 'break') and contains(.,'&amp;') or contains(.,'&gt;') or contains(.,'&lt;')
                or
                name() = 'insert' and contains(.,'&gt;') or contains(.,'&lt;')" id="pi-markup">Markup is not permitted in a processing instruction, see &ancestor_id;</report>
        <report test="name() = 'insert' and matches(., '&amp;#')" id='ampersand-in-pi-insert'>Found possible character reference in processing instruction <name/></report>
        
</rule>
</pattern>

<pattern id="insert-statements">
<title>Insert Processing Instructions for notes sections etc</title>
<rule context="processing-instruction(insert)" id="insert-context">
<report role="info" test="." id="insert-present">An insert processing instruction is present: <value-of select="."/></report>
<report test="contains(., 'end-ch-notes') and not(contains(., 'item='))" id="end-ch-notes-item">The end-ch-notes PI is not in the correct format. Does not contain 'item=', &check_ancestor;</report>
<report test="contains(., 'end-bk-notes') and not(contains(., 'item='))" id="end-bk-notes-item">The end-bk-notes PI is not in the correct format. Does not contain 'item=', &check_ancestor;</report>
        <report test="contains(., 'end-para-notes') and not(contains(., 'item='))" id="end-para-notes-item">The end-para-notes PI is not in the correct format. Does not contain 'item=', &check_ancestor;</report></rule>
<rule context="db:book[descendant::db:footnote[@role='end-bk-note']]" id="end-bk-note-context">
<assert test="descendant::processing-instruction(insert)[contains(.,'end-bk-notes')]" id="bk-insert-missing">Book contains 'end-bk-note' footnotes but there is no 'insert' PI present, &check_id;</assert>
</rule>
<rule context="db:chapter[descendant::db:footnote[@role='end-ch-note']] | db:preface[descendant::db:footnote[@role='end-ch-note']]" id="end-ch-note-context">
<assert test="descendant::processing-instruction(insert)[contains(.,'end-ch-notes')]" id="ch-insert-missing">Chunk contains 'end-ch-note' footnotes but there is no 'insert' PI present, &check_id;</assert>
</rule>
        <rule context="db:formalpara[descendant::db:footnote[@role='end-para-note']]" id="end-para-note-context">
                <assert test="descendant::processing-instruction(insert)[contains(.,'end-para-notes')]" id="para-insert-missing">Chunk contains 'end-para-note' footnotes but there is no 'insert' PI present, &check_id;</assert>
        </rule>
</pattern>

<pattern id="insert-statements-2">
<title>Checking that the insert statements have targets and titles</title>
<rule context="processing-instruction(insert)[contains(., 'end-bk-notes')]" id="insert-context-2">
&precedingPageNoVariable;
<let name="string1" value="substring-after(., 'chunk=')"/>
<let name="string2" value="substring-before($string1, ' ')"/>
<let name="string2Length" value="string-length($string2)"/>
<let name="chunkID" value="substring($string2, 2, ($string2Length - 2))"/>
<let name="titleString1" value="substring-after(., 'title=')"/>
<!-- key('xmlid', current()/@linkend) -->
<assert test="key('chunk-ids', $chunkID)" id="end-bk-notes-target">The end bk notes PI <value-of select="$chunkID"/> does not point to a chunk ID, &check_ancestor;</assert>
<report test="$chunkID = ''" id="end-bk-notes-incorrect">An end bk note PI does not have a chunk ID, &check_ancestor;</report>
<report test="count(key('chunk-pis', .)) gt 1" id="duplicate-end-bk-notes">There is a duplicated end-bk-note PI (target=<value-of select="$chunkID"/>), &check_ancestor;</report>
<assert test="contains($titleString1, ' ')" id="insert-pi-title" role="warning">The insert PI title does not contain a space (= "<value-of select="$titleString1"/>"). Is it correct? It should match the title &pageNoAndChunkPDF; &check_ancestor;</assert>
<assert test="matches($titleString1, '^&#x0022;\p{Lu}')" id="insert-pi-title2" role="warning">The insert PI title does not start with a capital letter (= <value-of select="$titleString1"/>). Is it correct? It should match the title &pageNoAndChunkPDF; &check_ancestor;</assert>
</rule>
</pattern>

<pattern id="insert-statements-3">
<title>Ensure that notes have correct @role when necessary</title>
<rule context="db:footnote" id="footnote-context">
<report test="not(@role='end-bk-note') and ancestor::db:book//processing-instruction(insert)[contains(., 'end-bk-notes')]" role="warning" id="end-bk-note-footnote">There is an end-bk-notes processing instruction in this book, but footnote does not have @role=end-bk-note, OK? &check_id;</report>
<report test="not(@role='end-ch-note') and (ancestor::db:chapter//processing-instruction(insert)[contains(., 'end-ch-notes')] or ancestor::db:preface//processing-instruction(insert)[contains(., 'end-ch-notes')] or ancestor::db:appendix//processing-instruction(insert)[contains(., 'end-ch-notes')])" role="warning" id="end-ch-note-footnote">There is an end-ch-notes processing instruction in this chunk, but footnote does not have @role=end-ch-note, OK? &check_id;</report>
        <report test="not(@role='end-para-note') and (ancestor::db:formalpara//processing-instruction(insert)[contains(., 'end-para-notes')])" role="warning" id="end-para-note-footnote">There is an end-para-notes processing instruction in this formalpara, but footnote does not have @role=end-para-note, OK? &check_id;</report></rule>
<rule context="&chunk_blocks;" id="chunk-context-2">
<let name="chunkNotesID" value="@xml:id"/>
<report test="descendant::db:footnote[@role='end-bk-note'] and not(self::db:part) and not(ancestor::db:book//processing-instruction(insert)[contains(., $chunkNotesID)])" id="missing-processing-instruction">The <name/> with id=<value-of select="@xml:id"/> contains end-bk-note footnotes, but there is no processing instruction for this chunk in the book</report>
<report test="descendant::db:footnote[@role='end-ch-note'] and not(descendant::processing-instruction(insert)[contains(., 'end-ch-notes')])" id="missing-processing-instruction2">The <name/> with id=<value-of select="@xml:id"/> contains end-ch-note footnotes, but there is no processing instruction for the notes in this chunk</report>
<report test="not(descendant::db:footnote[@role='end-ch-note']) and descendant::processing-instruction(insert)[contains(., 'end-ch-notes')]" id="processing-instruction-issue">The <name/> with id=<value-of select="@xml:id"/> contains an end-ch-note processing instruction, but there are no footnotes in this chunk</report>
</rule>
</pattern>

<!-- Pagination tests -->
<pattern id="pagenum-tests">
<title>Integrity tests for the chunk info/pagenums</title>
<!-- Note that it does not handle Roman numerals and excludes the front matter at present -->
        <rule context="db:info/db:pagenums[not(ancestor::db:part[@role='front']) and not(ancestor::db:part[db:info/db:biblioid[@otherclass='taxonRank']]) and not(ancestor::db:article)]" id="pagenums-context-2">
&precedingPageNoVariable;
<let name="startPage" value="if (contains(.,'–')) then (number(substring-before(.,'–'))) else (number(string()))"/>
<let name="endPage" value="if (contains(.,'–')) then (number(substring-after(.,'–'))) else (number(string()))"/>
<!-- Exclude pagenums in articles in the sequential page number checking -->
<let name="prevEndPage" value="if (contains(preceding::db:info[db:pagenums[not(ancestor::db:article)]][1]/db:pagenums,'–')) then (number(substring-after(preceding::db:info[db:pagenums[not(ancestor::db:article)]][1]/db:pagenums,'–'))) else (number(string(preceding::db:info[db:pagenums[not(ancestor::db:article)]][1]/db:pagenums)))"/>
<!-- The following works for sequential Arabic pages, but not Roman, and not at set boundaries -->
<assert test="$startPage = $prevEndPage + 1" role="warning" id="pagenums-sequence">Start page must normally be 1 more than previous end page [$startPage=<value-of select="$startPage"/>; $endPage=<value-of select="$endPage"/>; $prevEndPage=<value-of select="$prevEndPage"/>], see &ancestor_id; &pageNoAndChunkPDF;</assert>
</rule>
<rule context="db:info/db:pagenums[ancestor::db:part[@role='front']]" id="pagenums-context-3">
&precedingPageNoVariable;
<let name="startPage" value="number(substring-before(.,'–'))"/>
<report test="$startPage = 1" role="warning" id="page-1-front">Page number 1 is in the front matter; is that correct? &check_ancestor; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

<pattern id="pagenum-tests2">
<title>Integrity tests for all info/pagenums (chunks and articles)</title>
<!-- Note that it does not handle Roman numerals and excludes the front matter at present -->
<rule context="db:info/db:pagenums[not(ancestor::db:part[@role='front'])]" id="pagenums-context-4">
&precedingPageNoVariable;
<let name="startPage" value="if (contains(.,'–')) then (number(substring-before(.,'–'))) else (number(string()))"/>
<let name="endPage" value="if (contains(.,'–')) then (number(substring-after(.,'–'))) else (number(string()))"/>
<report test="if (contains(.,'–')) then ($startPage = $endPage) else 0" role="error" id="single-page">If start page is the same as end page, remove the ndash and only contain a single value [$startPage=<value-of select="$startPage"/>; $endPage=<value-of select="$endPage"/>], see &ancestor_id; &pageNoAndChunkPDF;</report>
<!-- The following does not handle Roman numbers -->
<assert test="if (contains(.,'–')) then ($startPage lt $endPage) else ($startPage = $endPage)" role="warning" id="endp-before-startp">Start page must be before end page [$startPage=<value-of select="$startPage"/>; $endPage=<value-of select="$endPage"/>], see &ancestor_id; &pageNoAndChunkPDF;</assert>
<report test="matches(., '[civx]+')" role="warning" id="poss-front-matter">Page number range contains a Roman number; should this chunk be in the Front matter? &check_id; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

<!-- Page numbers in processing instructions -->
<pattern id="page-numbers-present">
<title>Page number format</title>
<rule context="db:book[@role='fullText'][not(@outoutformat='e-Only')]" id="fulltext-context-2">
<report test="descendant::processing-instruction(break)[contains(., 'page')]" id="page-breaks-missing">Page break markers are not present in the correct format</report>
</rule>
<rule context="processing-instruction(page)" id="page-context">
<assert test="contains(., 'value=')" id="page-break-format">A page break processing instruction does not have a "value" [<value-of select="."/>], &ancestor_id;</assert>
</rule>
</pattern>

<pattern id="page-numbers-absent">
<title>Page numbers absent</title>
<rule context="db:book[@role='fullText'][not(@outputformat='e-Only')]" id="fulltext-context-3">
<assert test="descendant::processing-instruction(page)" id="page-breaks-missing-2">There are no page break markers in this book</assert>
</rule>
</pattern>
        <pattern id="page-numbers-present2">
                <title>Page numbers present</title>
                <rule context="db:book[@role='fullText'][@outputformat='e-Only']" id="fulltext-context-4">
                        <report test="descendant::processing-instruction(page)" id="page-breaks-present">Page break markers must not be in a book that is @outputformat=e-Only</report>
                </rule>
        </pattern>

<pattern id="page-no-sequence">
<title>Page number sequence</title>
<rule context="processing-instruction(page)[not(ancestor::db:part[@role='front'])]" id="page-context-2">
<let name="string1" value="substring-after(., '=')"/>
<let name="pageNo" value="number(translate($string1, '&#x0022;', ''))"/>
<let name="string2" value="preceding::processing-instruction(page)[1]/substring-after(., '=')"/>
<let name="precedingPageNo" value="number(translate($string2, '&#x0022;', ''))"/>
<let name="string3" value="following::processing-instruction(page)[1]/substring-after(., '=')"/>
<let name="followingPageNo" value="number(translate($string3, '&#x0022;', ''))"/>
<assert test="if (string($precedingPageNo) eq 'NaN') then . else ($precedingPageNo = $pageNo - 1)" role="warning" id="page-break-sequence-2">Problem with numbering of page break markers &chunk_pdf;: at page <value-of select="$pageNo"/>; preceding page no = <value-of select="$precedingPageNo"/>; following page no = <value-of select="$followingPageNo"/></assert>
</rule>
</pattern>

<pattern id="page-no-consistency">
<title>Page number consistency</title>
        <rule context="element()[db:info/db:pagenums][not(ancestor::db:part[@role='front']) and not(self::db:article) and not(db:info/db:biblioid[@otherclass='taxonRank']) and not(ancestor::db:book[@role='pdfOnly'])]" id="pn-context-1">
<let name="startPage" value="if (contains(db:info/db:pagenums,'–')) then (number(substring-before(db:info/db:pagenums,'–'))) else (number(string(db:info/db:pagenums)))"/>
<let name="endPage" value="if (contains(db:info/db:pagenums,'–')) then (number(substring-after(db:info/db:pagenums,'–'))) else (number(string(db:info/db:pagenums)))"/>
<let name="PIstring1" value="substring-after(descendant::processing-instruction(page)[1], '=')"/>
<let name="PIpageNo1" value="number(translate($PIstring1, '&#x0022;', ''))"/>
<let name="PIstringLast" value="substring-after(descendant::processing-instruction(page)[position()=last()], '=')"/>
<let name="PIpageNoLast" value="number(translate($PIstringLast, '&#x0022;', ''))"/>
<assert id="page-no-match1" test="$startPage = $PIpageNo1" role="warning">The start page in pagenums (<value-of select="$startPage"/>) must match the first page number value in this chunk in the page PI (<value-of select="$PIpageNo1"/>), &check_id;</assert>
</rule>
</pattern>

<pattern id="page-no-consistency2">
<title>Page number consistency</title>
        <rule context="element()[db:info/db:pagenums][not(ancestor::db:part[@role='front'])][not(self::db:part) and not(self::db:article) and not(db:info/db:biblioid[@otherclass='taxonRank']) and not(ancestor::db:book[@role='pdfOnly'])]" id="pn-context-2">
<let name="startPage" value="if (contains(db:info/db:pagenums,'–')) then (number(substring-before(db:info/db:pagenums,'–'))) else (number(string(db:info/db:pagenums)))"/>
<let name="endPage" value="if (contains(db:info/db:pagenums,'–')) then (number(substring-after(db:info/db:pagenums,'–'))) else (number(string(db:info/db:pagenums)))"/>
<let name="PIstring1" value="substring-after(descendant::processing-instruction(page)[1], '=')"/>
<let name="PIpageNo1" value="number(translate($PIstring1, '&#x0022;', ''))"/>
<let name="PIstringLast" value="substring-after(descendant::processing-instruction(page)[position()=last()], '=')"/>
<let name="PIpageNoLast" value="number(translate($PIstringLast, '&#x0022;', ''))"/>
<assert id="page-no-match2" test="$endPage = $PIpageNoLast" role="warning">The end page in pagenums (<value-of select="$endPage"/>) must match the last page number value in this chunk in the page PI (<value-of select="$PIpageNoLast"/>), &check_id;</assert>
</rule>
</pattern>

<pattern id="page-no-placement">
<title>Page break placement</title>
<rule context="processing-instruction(page)" id="page-context-3">
<report test="following-sibling::node()[1][self::processing-instruction(page)]" role="warning" id="page-break-sequence">Page break processing instructions should not normally follow each other; should one be in previous chunk?. &chunk_pdf; &check_ancestor;</report>
<report test="preceding-sibling::element()[1][self::db:info]" id="info-before-pb" role="warning">A page break PI should not usually be the first node after an info. Does it need to go before the containing block, or in the info/title (if it's a chunk)? &chunk_pdf; &check_ancestor;</report>
<report test="following-sibling::element()[1][self::db:info]" id="info-after-pb">A page break PI should not be the first node before an info. Does it need to go before the containing block, or in the info/title (if it's a chunk)? &chunk_pdf; &check_ancestor;</report>
<report test="ancestor::db:footnote" id="pb-in-footnote">Page break processing instructions are not permitted in footnotes &chunk_pdf;, &check_ancestor;</report>
</rule>
<rule context="db:bibliomixed | db:para | db:listitem | db:informaltable | db:informalfigure" id="pb-context">
<report test="descendant::processing-instruction(page)[not(preceding-sibling::node())]" role="warning" id="page-break-pos-2">Page break processing instructions should not normally be the first node in a <name/>; should it be between <name/>s or in previous chunk?. &chunk_pdf; &check_id;</report>
<report test="descendant::processing-instruction(page)[not(following-sibling::node())]" role="warning" id="page-break-pos-3">Page break processing instructions should not normally be the last node in a <name/>; should it be between <name/>s or in previous chunk?. &chunk_pdf; &check_id;</report>
</rule>
<rule context="db:info/db:title[not(parent::db:info/parent::db:preface or parent::db:info/parent::db:acknowledgements or parent::db:info/parent::db:toc or parent::db:info/parent::db:glossary or parent::db:info/parent::db:chapter or parent::db:info/parent::db:appendix or parent::db:info/parent::db:bibliography[parent::db:book or parent::db:part] or parent::db:info/parent::db:dedication or parent::db:info/parent::db:part or parent::db:info/parent::db:index or parent::db:info/parent::db:article or parent::db:info/parent::db:partintro)]" id="pb-context-2">
<report test="processing-instruction(page)" id="pb-section-title">A page break processing instruction should not be in a <name path="parent::db:info/parent::element()"/> title; move it so it is immediately before the <name path="parent::db:info/parent::element()"/> element, &chunk_pdf; &ancestor_id;</report>
</rule>
</pattern>

<pattern id="processing-instructions">
<title>More PI rules</title>
<rule context="processing-instruction()" id="pi-context">
<report test="parent::db:book or parent::db:info or parent::db:part or parent::db:mediaobject or parent::db:imageobject or parent::db:videoobject or parent::db:audioobject or parent::db:primary or parent::db:secondary or parent::db:tertiary or parent::db:see or parent::db:seealso or parent::db:alt or parent::db:inlinemediaobject or parent::db:remark or parent::db:indexterm or parent::db:itermset or parent::db:varlistentry or parent::db:figure or parent::db:informalfigure" id="page-break-pos-1">Processing instructions must not be immediate children of <name path="parent::element()"/>. &chunk_pdf; &check_id;</report>
</rule>
</pattern>

<pattern id="columns">
<title>Column PIs</title>
<rule context="db:book" id="book-pi-context">
&precedingPageNoVariable;
<report test="descendant::processing-instruction(break)[contains(., 'column')]" role="information" id="columns-present">Column processing instructions are present, &check_id; &pageNoAndChunkPDF;</report>
</rule>
</pattern>

<pattern id="line-breaks">
<title>Line break processing instructions</title>
<rule context="processing-instruction(break)" id="break-context">
&precedingPageNoVariable;
<report test="contains(.,'line')" role="warning" id="line-break-present">A line break marker is present; is that correct?, &check_ancestor; &pageNoAndChunkPDF;</report>
        <assert test="contains(., 'type=')" id="break-type">A break processing instruction must contain a 'type', &check_ancestor;</assert>
        <assert test="contains(., 'line') or contains(., 'column') or contains(., 'column-start') or contains(., 'column-end')" id="break-typology">A break processing instruction must have type="line | column | column-start | column-end"</assert>
</rule>
</pattern>



<!-- Following to the end is copied from the DocBook standard tool set, with a few items commented out-->
   <pattern id="Glossary-firstterm-type-constraint">
<title>Glossary 'firstterm' type constraint</title>
      <rule context="db:firstterm[@linkend]" id="firstterm-context">
         <assert test="local-name(//*[@xml:id=current()/@linkend]) = 'glossentry' and namespace-uri(//*[@xml:id=current()/@linkend]) = 'http://docbook.org/ns/docbook'" id="a-1">@linkend on firstterm must point to a glossentry.</assert>
      </rule>
   </pattern>
   <pattern id="Footnote-reference-type-constraint">
<title>Footnote reference type constraint</title>
      <rule context="db:footnoteref" id="footnoteref-context">
         <assert test="local-name(//*[@xml:id=current()/@linkend]) = 'footnote' and namespace-uri(//*[@xml:id=current()/@linkend]) = 'http://docbook.org/ns/docbook'" id="footnoteref-target">@linkend on footnoteref must point to a footnote.</assert>
         <report test="@label" role="warning" id="footnoteref-label">@label on footnoteref is almost certainly not correct &check_ancestor;</report>
      </rule>
   </pattern>
   <pattern id="Glossary-glossterm-type-constraint">
<title>Glossary 'glossterm' type constraint</title>
      <rule context="db:glossterm[@linkend]" id="glossterm-context">
         <assert test="local-name(//*[@xml:id=current()/@linkend]) = 'glossentry' and namespace-uri(//*[@xml:id=current()/@linkend]) = 'http://docbook.org/ns/docbook'" id="a-2">@linkend on glossterm must point to a glossentry.</assert>
      </rule>
   </pattern>
   <pattern id="Synopsis-fragment-type-constraint">
<title>Synopsis fragment type constraint</title>
      <rule context="db:synopfragmentref" id="synopfrag-context">
         <assert test="local-name(//*[@xml:id=current()/@linkend]) = 'synopfragment' and namespace-uri(//*[@xml:id=current()/@linkend]) = 'http://docbook.org/ns/docbook'" id="a3">@linkend on synopfragmentref must point to a synopfragment.</assert>
      </rule>
   </pattern>
   <pattern id="Glossary-see-type-constraint">
<title>Glossary 'see' type constraint</title>
      <rule context="db:glosssee[@otherterm]" id="glosssee-context">
         <assert test="local-name(//*[@xml:id=current()/@otherterm]) = 'glossentry' and namespace-uri(//*[@xml:id=current()/@otherterm]) = 'http://docbook.org/ns/docbook'" id="a4">@otherterm on glosssee must point to a glossentry.</assert>
      </rule>
   </pattern>
   <pattern id="Glossary-seealso-type-constraint">
<title>Glossary 'seealso' type constraint</title>
      <rule context="db:glossseealso[@otherterm]" id="glossseealso-context">
         <assert test="local-name(//*[@xml:id=current()/@otherterm]) = 'glossentry' and namespace-uri(//*[@xml:id=current()/@otherterm]) = 'http://docbook.org/ns/docbook'" id="a5">@otherterm on glossseealso must point to a glossentry.</assert>
      </rule>
   </pattern>
   <pattern id="Glossary-term-definition-constraint">
<title>Glossary term definition constraint</title>
      <rule context="db:termdef" id="termdef-context">
         <assert test="count(db:firstterm) = 1" id="a6">A termdef must contain exactly one firstterm</assert>
      </rule>
   </pattern>
   <pattern id="Cardinality-of-segments-and-titles">
<title>Cardinality of segments and titles</title>
      <rule context="db:seglistitem" id="seglistitem-context">
         <assert test="count(db:seg) = count(../db:segtitle)" id="a7">The number of seg elements must be the same as the number of segtitle elements in the parent segmentedlist</assert>
      </rule>
   </pattern>
   <pattern id="Root-must-have-version">
<title>Root must have version</title>
      <rule context="/db:para" id="v-context-1">
         <assert test="@version" id="a8">The root element must have a version attribute.</assert>
      </rule>
      <rule context="/db:set" id="v-context-2">
         <assert test="@version" id="a9">The root element must have a version attribute.</assert>
      </rule>
      <rule context="/db:book" id="v-context-3">
         <assert test="@version" id="q1">The root element must have a version attribute.</assert>
      </rule>
      <rule context="/db:dedication" id="v-context-4">
         <assert test="@version" id="q2">The root element must have a version attribute.</assert>
      </rule>
      <rule context="/db:acknowledgements" id="v-context-5">
         <assert test="@version" id="q3">The root element must have a version attribute.</assert>
      </rule>
      <rule context="/db:colophon" id="v-context-6">
         <assert test="@version" id="q4">The root element must have a version attribute.</assert>
      </rule>
      <rule context="/db:appendix" id="v-context-7">
         <assert test="@version" id="q5">The root element must have a version attribute.</assert>
      </rule>
      <rule context="/db:chapter" id="v-context-8">
         <assert test="@version" id="q6">The root element must have a version attribute.</assert>
      </rule>
      <rule context="/db:part" id="v-context-9">
         <assert test="@version" id="q7">The root element must have a version attribute.</assert>
      </rule>
      <rule context="/db:preface" id="v-context-10">
         <assert test="@version" id="q8">The root element must have a version attribute.</assert>
      </rule>
      <rule context="/db:section" id="v-context-11">
         <assert test="@version" id="q9">The root element must have a version attribute.</assert>
      </rule>
      <rule context="/db:article" id="v-context-12">
         <assert test="@version" id="w1">The root element must have a version attribute.</assert>
      </rule>
      <rule context="/db:sect1" id="v-context-13">
         <assert test="@version" id="w2">The root element must have a version attribute.</assert>
      </rule>
      <rule context="/db:sect2" id="v-context-14">
         <assert test="@version" id="w3">The root element must have a version attribute.</assert>
      </rule>
      <rule context="/db:sect3" id="v-context-15">
         <assert test="@version" id="w4">The root element must have a version attribute.</assert>
      </rule>
      <rule context="/db:sect4" id="v-context-16">
         <assert test="@version" id="w5">The root element must have a version attribute.</assert>
      </rule>
      <rule context="/db:sect5" id="v-context-17">
         <assert test="@version" id="w6">The root element must have a version attribute.</assert>
      </rule>
      <rule context="/db:reference" id="v-context-18">
         <assert test="@version" id="w7">The root element must have a version attribute.</assert>
      </rule>
      <rule context="/db:refentry" id="v-context-19">
         <assert test="@version" id="w8">The root element must have a version attribute.</assert>
      </rule>
      <rule context="/db:refsection" id="v-context-21">
         <assert test="@version" id="w9">The root element must have a version attribute.</assert>
      </rule>
      <rule context="/db:refsect1" id="v-context-22">
         <assert test="@version" id="e1">The root element must have a version attribute.</assert>
      </rule>
      <rule context="/db:refsect2" id="v-context-23">
         <assert test="@version" id="e2">The root element must have a version attribute.</assert>
      </rule>
      <rule context="/db:refsect3" id="v-context-24">
         <assert test="@version" id="e3">The root element must have a version attribute.</assert>
      </rule>
      <rule context="/db:glossary" id="v-context-25">
         <assert test="@version" id="e4">The root element must have a version attribute.</assert>
      </rule>
      <rule context="/db:bibliography" id="v-context-26">
         <assert test="@version" id="e5">The root element must have a version attribute.</assert>
      </rule>
      <rule context="/db:index" id="v-context-27">
         <assert test="@version" id="e6">The root element must have a version attribute.</assert>
      </rule>
      <rule context="/db:setindex" id="v-context-28">
         <assert test="@version" id="e7">The root element must have a version attribute.</assert>
      </rule>
      <rule context="/db:toc" id="v-context-29">
         <assert test="@version" id="e8">The root element must have a version attribute.</assert>
      </rule>
   </pattern>
   <pattern id="Element-exclusion">
<title>Element exclusion</title>
      <rule context="db:annotation" id="annotation-context">
         <assert test="not(.//db:annotation)" id="e9">annotation must not occur in the descendants of annotation</assert>
      </rule>
      <rule context="db:caution" id="caution-context">
         <assert test="not(.//db:caution)" id="a1">caution must not occur in the descendants of caution</assert>
         <assert test="not(.//db:important)" id="z1">important must not occur in the descendants of caution</assert>
         <assert test="not(.//db:note)" id="z2">note must not occur in the descendants of caution</assert>
         <assert test="not(.//db:tip)" id="z3">tip must not occur in the descendants of caution</assert>
         <assert test="not(.//db:warning)" id="z4">warning must not occur in the descendants of caution</assert>
      </rule>
      <rule context="db:important" id="important-context">
         <assert test="not(.//db:caution)" id="z5">caution must not occur in the descendants of important</assert>
         <assert test="not(.//db:important)" id="z6">important must not occur in the descendants of important</assert>
         <assert test="not(.//db:note)" id="z7">note must not occur in the descendants of important</assert>
         <assert test="not(.//db:tip)" id="z8">tip must not occur in the descendants of important</assert>
         <assert test="not(.//db:warning)" id="z9">warning must not occur in the descendants of important</assert>
      </rule>
      <rule context="db:note" id="note-context-2">
         <assert test="not(.//db:caution)" id="x1">caution must not occur in the descendants of note</assert>
         <assert test="not(.//db:important)" id="x2">important must not occur in the descendants of note</assert>
         <!--<assert test="not(.//db:note)" id="x3">note must not occur in the descendants of note</assert>-->
         <assert test="not(.//db:tip)" id="x4">tip must not occur in the descendants of note</assert>
         <assert test="not(.//db:warning)" id="x5">warning must not occur in the descendants of note</assert>
      </rule>
      <rule context="db:tip" id="tip-context">
         <assert test="not(.//db:caution)" id="x6">caution must not occur in the descendants of tip</assert>
         <assert test="not(.//db:important)" id="x7">important must not occur in the descendants of tip</assert>
         <assert test="not(.//db:note)" id="x8">note must not occur in the descendants of tip</assert>
         <assert test="not(.//db:tip)" id="x9">tip must not occur in the descendants of tip</assert>
         <assert test="not(.//db:warning)" id="s1">warning must not occur in the descendants of tip</assert>
      </rule>
      <rule context="db:warning" id="warning-context">
         <assert test="not(.//db:caution)" id="s2">caution must not occur in the descendants of warning</assert>
         <assert test="not(.//db:important)" id="s3">important must not occur in the descendants of warning</assert>
         <assert test="not(.//db:note)" id="s4">note must not occur in the descendants of warning</assert>
         <assert test="not(.//db:tip)" id="s5">tip must not occur in the descendants of warning</assert>
         <assert test="not(.//db:warning)" id="s6">warning must not occur in the descendants of warning</assert>
      </rule>
      <rule context="db:caption" id="caption-context">
         <assert test="not(.//db:caution)" id="s7">caution must not occur in the descendants of caption</assert>
         <assert test="not(.//db:equation)" id="s8">equation must not occur in the descendants of caption</assert>
         <assert test="not(.//db:example)" id="s9">example must not occur in the descendants of caption</assert>
         <assert test="not(.//db:figure)" id="c1">figure must not occur in the descendants of caption</assert>
         <assert test="not(.//db:important)" id="c2">important must not occur in the descendants of caption</assert>
         <assert test="not(.//db:note)" id="c3">note must not occur in the descendants of caption</assert>
         <assert test="not(.//db:sidebar)" id="c4">sidebar must not occur in the descendants of caption</assert>
         <assert test="not(.//db:table)" id="c5">table must not occur in the descendants of caption</assert>
         <assert test="not(.//db:task)" id="c6">task must not occur in the descendants of caption</assert>
         <assert test="not(.//db:tip)" id="c7">tip must not occur in the descendants of caption</assert>
         <assert test="not(.//db:warning)" id="c8">warning must not occur in the descendants of caption</assert>
      </rule>
      <rule context="db:equation" id="equation-context-4">
         <assert test="not(.//db:caution)" id="c9">caution must not occur in the descendants of equation</assert>
         <assert test="not(.//db:equation)" id="v1">equation must not occur in the descendants of equation</assert>
         <assert test="not(.//db:example)" id="v2">example must not occur in the descendants of equation</assert>
         <assert test="not(.//db:figure)" id="v3">figure must not occur in the descendants of equation</assert>
         <assert test="not(.//db:important)" id="v4">important must not occur in the descendants of equation</assert>
         <assert test="not(.//db:note)" id="v5">note must not occur in the descendants of equation</assert>
         <assert test="not(.//db:table)" id="v6">table must not occur in the descendants of equation</assert>
         <assert test="not(.//db:tip)" id="v7">tip must not occur in the descendants of equation</assert>
         <assert test="not(.//db:warning)" id="v8">warning must not occur in the descendants of equation</assert>
      </rule>
      <rule context="db:example" id="example-context">
         <assert test="not(.//db:caution)" id="v9">caution must not occur in the descendants of example</assert>
         <assert test="not(.//db:equation)" id="b1">equation must not occur in the descendants of example</assert>
         <assert test="not(.//db:example)" id="b2">example must not occur in the descendants of example</assert>
         <assert test="not(.//db:figure)" id="b3">figure must not occur in the descendants of example</assert>
         <assert test="not(.//db:important)" id="b4">important must not occur in the descendants of example</assert>
         <assert test="not(.//db:note)" id="b5">note must not occur in the descendants of example</assert>
         <assert test="not(.//db:table)" id="b6">table must not occur in the descendants of example</assert>
         <assert test="not(.//db:tip)" id="b7">tip must not occur in the descendants of example</assert>
         <assert test="not(.//db:warning)" id="b8">warning must not occur in the descendants of example</assert>
      </rule>
      <rule context="db:figure" id="fig-context">
         <assert test="not(.//db:caution)" id="b9">caution must not occur in the descendants of figure</assert>
         <assert test="not(.//db:equation)" id="d1">equation must not occur in the descendants of figure</assert>
         <assert test="not(.//db:example)" id="d2">example must not occur in the descendants of figure</assert>
         <assert test="not(.//db:figure)" id="d3">figure must not occur in the descendants of figure</assert>
         <assert test="not(.//db:important)" id="d4">important must not occur in the descendants of figure</assert>
         <assert test="not(.//db:note)" id="d5">note must not occur in the descendants of figure</assert>
         <assert test="not(.//db:table)" id="d6">table must not occur in the descendants of figure</assert>
         <assert test="not(.//db:tip)" id="d7">tip must not occur in the descendants of figure</assert>
         <assert test="not(.//db:warning)" id="d8">warning must not occur in the descendants of figure</assert>
      </rule>
      <rule context="db:table" id="table-context">
         <assert test="not(.//db:caution)" id="d9">caution must not occur in the descendants of table</assert>
         <assert test="not(.//db:equation)" id="f1">equation must not occur in the descendants of table</assert>
         <assert test="not(.//db:example)" id="f2">example must not occur in the descendants of table</assert>
         <assert test="not(.//db:figure)" role="warning" id="f3">figure must not usually occur in the descendants of table</assert>
         <assert test="not(.//db:important)" id="f4">important must not occur in the descendants of table</assert>
         <!--<assert test="not(.//db:informaltable)">informaltable must not occur in the descendants of table</assert>-->
         <assert test="not(.//db:note)" id="f5">note must not occur in the descendants of table</assert>
         <assert test="not(.//db:tip)" id="f6">tip must not occur in the descendants of table</assert>
         <assert test="not(.//db:warning)" id="f7">warning must not occur in the descendants of table</assert>
      </rule>
      <rule context="db:footnote" id="footnote-context-6">
         <assert test="not(.//db:caution)" id="f8">caution must not occur in the descendants of footnote</assert>
         <assert test="not(.//db:epigraph)" id="f9">epigraph must not occur in the descendants of footnote</assert>
         <!--<assert test="not(.//db:equation)">equation must not occur in the descendants of footnote</assert>-->
         <assert test="not(.//db:example)" id="fo">example must not occur in the descendants of footnote</assert>
         <!--<assert test="not(.//db:figure)" id="fp">figure must not occur in the descendants of footnote</assert>-->
         <assert test="not(.//db:footnote)" id="fl">footnote must not occur in the descendants of footnote</assert>
         <assert test="not(.//db:important)" id="fm">important must not occur in the descendants of footnote</assert>
         <!--<assert test="not(.//db:indexterm)">indexterm must not occur in the descendants of footnote</assert>-->
         <assert test="not(.//db:note)" id="fn">note must not occur in the descendants of footnote</assert>
         <assert test="not(.//db:sidebar)" id="fb">sidebar must not occur in the descendants of footnote</assert>
<!-- Following is not true, so removed -->
         <!--<assert test="not(.//db:table)">table must not occur in the descendants of footnote</assert>-->
         <assert test="not(.//db:task)" id="fv">task must not occur in the descendants of footnote</assert>
         <assert test="not(.//db:tip)" id="fg">tip must not occur in the descendants of footnote</assert>
         <assert test="not(.//db:warning)" id="ff">warning must not occur in the descendants of footnote</assert>
      </rule>
<!-- Excluded plate sections, since it is possible for them to occur within a proper sidebar -->
      <rule context="db:sidebar" id="sidebar-context-2">
         <assert test="not(.//db:sidebar[not(@role='plateSection')])" id="ft">sidebar must not occur in the descendants of sidebar</assert>
      </rule>
   </pattern>
	
</schema>