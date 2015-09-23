const synset_test_line = string(
    "13134947 20 n 01 fruit 0 037 @ 11675842 n 0000 + 02397119 a 0101 + 101",
    "13997 n 0101 + 13135692 n 0101 + 01652731 v 0101 + 01652895 v 0101 + 0",
    "0506672 v 0101 + 00056188 v 0101 ~ 07705931 n 0000 ~ 11636835 n 0000 ~",
    " 11700279 n 0000 ~ 12036067 n 0000 ~ 12158031 n 0000 ~ 12162758 n 0000",
    " ~ 12193334 n 0000 ~ 12267677 n 0000 ~ 12301445 n 0000 ~ 12620546 n 00",
    "00 ~ 12642090 n 0000 ~ 12644283 n 0000 ~ 12647787 n 0000 ~ 12650805 n ",
    "0000 ~ 12658481 n 0000 ~ 12737251 n 0000 ~ 13133613 n 0000 ~ 13135692 ",
    "n 0000 ~ 13135832 n 0000 ~ 13137409 n 0000 ~ 13137672 n 0000 ~ 1313830",
    "8 n 0000 ~ 13138842 n 0000 ~ 13139055 n 0000 ~ 13139482 n 0000 ~ 13140",
    "367 n 0000 ~ 13141415 n 0000 ~ 13150378 n 0000 ~ 13150592 n 0000 | the",
    " ripened reproductive body of a seed plant"   
)

const synset_test_line_2 = string(
    "00074790 04 n 0b blunder 0 blooper 0 bloomer 0 bungle 0 pratfall 0 fou",
    "l-up 0 fuckup 0 flub 0 botch 0 boner 0 boo-boo 0 019 @ 00070965 n 0000",
    " + 02229000 a 0901 + 02527651 v 0901 + 02527651 v 0808 + 02527651 v 07",
    "18 + 02527651 v 0616 + 02527651 v 040d + 00013172 v 0401 + 02566227 v ",
    "0103 ~ 00071864 n 0000 ~ 00075283 n 0000 ~ 00075471 n 0000 ~ 00075790 ",
    "n 0000 ~ 00075912 n 0000 ~ 00076072 n 0000 ~ 00076196 n 0000 ~ 0007632",
    "3 n 0000 ~ 00076393 n 0000 ~ 00076563 n 0000 | an embarrassing mistake"
)

const synset_test_line_3 = string(
    "10951697 18 n 03 Edward a Edward_VIII 0 Duke_of_Windsor 0 002 @i 10233",
    "445 n 0000 #m 08159740 n 0000 | King of England and Ireland in 1936; h",
    "is marriage to Wallis Warfield Simpson created a constitutional crisis"
)

facts("Synset") do 
    ss = Synset(synset_test_line, 'n')

    context("constructor") do
        @fact ss.synset_type --> 'n'
        @fact ss.gloss --> "the ripened reproductive body of a seed plant"
        @fact collect(words(ss)) --> ["fruit"] 
    end

    context("parses n_words from a hex string") do
        hex_ss = Synset(synset_test_line_2, 'n') 
        @fact hex_ss.gloss --> "an embarrassing mistake"
    end

    context("parses the lex_id as a hex string") do 
        hex_ss = Synset(synset_test_line_3, 'n') 
    end

    context("words") do 
        @fact collect(words(ss)) --> ["fruit"] 
    end

    context("word_count") do 
        @fact word_count(ss) --> 1
    end

    context("show") do 
        expected = "(n) fruit (the ripened reproductive body of a seed plant)"
        @fact io_to_string(io -> show(io, ss)) --> expected
    end

    context("is_nothing") do
        @fact WordNet.is_nothing(WordNet.∅) --> true
    end
end

facts("helpers") do 
    context("parse_int_hex") do 
        @fact WordNet.parse_int_hex("a") --> 10
    end
end