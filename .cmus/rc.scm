(import (only (scheme char) string-upcase))

(define (string-suffix? str suf)
  (let ((str-len (string-length str))
        (suf-len (string-length suf)))
    (if (<= str-len suf-len)
      #f
      (equal? (substring str (- str-len suf-len))
              suf))))

(define (string-last str chr)
  (define (string-last-iter i)
    (cond
      ((<= i 0) -1)
      ((char=? (string-ref str i) chr) i)
      (else (string-last-iter (- i 1)))))
  (string-last-iter (- (string-length str) 1)))

(define (shell-quote str)
  (define (*shell-quote l)
    (if (not (null? l))
      (let ((next (cdr l)))
        (if (char=? (car l) #\")
          (set-cdr! l (cons #\\ next)))
        (*shell-quote next))))
  (let ((rev (reverse (string->list str))))
    (*shell-quote rev)
    (list->string (append (cons #\" (reverse rev)) '(#\")))))

(define (selected-folder)
  (let ((sel (selected-file)))
    (substring sel
               0
               (+ (string-last sel #\/) 1))))

(define (selected-filename)
  (let ((sel (selected-file)))
    (substring sel
               (string-last sel #\/)
               (string-length sel))))

(define (id3? file)
  (string-suffix? file ".mp3"))

(define (ogg? file)
  (string-suffix? file ".ogg"))

(define (flac? file)
  (string-suffix? file ".flac"))

(define (long-opt opt)
  (string-append "--" opt))

(define (set-tag track tag value)

  (define (handle-id3)
    (define (set-id3v2 opt)
      (shell "id3v2" (long-opt opt) (shell-quote value) (shell-quote track)))
    (cond
      ((equal? tag "year") (set-id3v2 "TYER"))
      ((equal? tag "title") (set-id3v2 "song"))
      ((equal? tag "label") (set-id3v2 "TPUB"))
      (else (set-id3v2 tag))))

  (define (handle-flac)
    (define (set-metaflac uptag)
      (shell "metaflac"
             (string-append "--remove-tag=" (shell-quote uptag))
             (shell-quote track))
      (shell "metaflac"
             (shell-quote (string-append "--set-tag=" uptag "=" value))
             (shell-quote track)))
    (cond
      ((equal? tag "year") (set-metaflac "DATE"))
      (else (set-metaflac (string-upcase tag)))))

  (cond
    ((id3? track) (handle-id3))
    ((ogg? track) (echo "TODO: ogg metadata"))
    ((flac? track) (handle-flac))))

(define (tag-selected tag value)
  (set-tag (selected-file) tag value))

(define aux-colors '("color_aux1"
                     "color_aux2"
                     "color_aux3"
                     "color_aux4"
                     "color_aux5"
                     "color_aux6"
                     "color_aux7"
                     "color_aux8"))

(define fg-colors '("color_cmdline_fg"
                    "color_statusline_fg"
                    "color_titleline_fg"
                    "color_win_cur_sel_fg"
                    "color_win_fg"
                    "color_win_inactive_cur_sel_fg"
                    "color_win_inactive_sel_fg"
                    "color_win_sel_fg"
                    "color_win_title_fg"))

(define bg-colors '("color_cmdline_bg"
                    "color_statusline_bg"
                    "color_titleline_bg"
                    "color_win_cur_sel_bg"
                    "color_win_bg"
                    "color_win_inactive_cur_sel_bg"
                    "color_win_inactive_sel_bg"
                    "color_win_sel_bg"
                    "color_win_title_bg"))

(define msg-colors '("color_error" "color_info"))

(define (get-color-value opt)
  (color->number (get-option opt)))

(define (frob-color! proc opt)
  (define (frob-color opt)
    (number->string (proc (get-color-value opt))))
  (set-option! opt (frob-color opt)))

(define (frob-colors! proc colors)
  (for-each (lambda (x) (frob-color! proc x)) colors))

(define (adjust-colors! val)
  (frob-colors! (lambda (x) (+ x val)) aux-colors))
