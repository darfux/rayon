;; http client
(ql:quickload :drakma)
(ql:quickload :cl-json)
(ql:quickload :st-json)
;; GBK codec facility
(ql:quickload :babel)
;; regexp facility
(ql:quickload :cl-ppcre)
;; string split
(ql:quickload :split-sequence)
;; html-parsing
(ql:quickload :closure-html)
;; base64 utility
(ql:quickload :cl-base64)

;; return values of drakma:http-request
(defparameter *body* nil)
(defparameter *status* nil)
(defparameter *headers* nil)
(defparameter *URI* nil)
(defparameter *stream* nil)
(defparameter *closed* nil)
(defparameter *reason* nil)
(defparameter *cookie* nil)


(defun test ()
  "print return values of drakma:http-request"
  (with-output-to-string (*standard-output*)
  ;; (princ *body*)
    (print *status*)
    (print *headers*)
    (print *URI*)
    (print *stream*)
    (print *closed*)
    (print *reason*)))

(defun string-to-keyword (name)
  "string-to-keyword
http://stackoverflow.com/questions/211717/common-lisp-programmatic-keyword
origin: sky-pher"
  (values (intern (string-upcase name) "KEYWORD")))

(defun get-URL (url &rest args)
  "url is a string
visit url using GET
if args, apply it to http-request
result saved to global variables."
  (multiple-value-bind (body status-code headers URI stream should-be-closed reason)
      (apply #'drakma:http-request url args)
    (setf *body* (let ((s (cl-ppcre:scan-to-strings
			   "charset=.*"
			   (cdr (assoc :content-type headers)))))
		   (cond ((stringp body) ;;成功解码
			  body) 
			 ((and s (not (string= "" s))) ;;找到charset
			  (babel:octets-to-string body :encoding (string-to-keyword
								  (let ((s (subseq s 8)))
								    (if (string= s "gb2312")
									"gbk"
									s))))) ;; 转码
			 (t body))) ;; 否则是ascii流了
	  *status* status-code
	  *headers* headers
	  *URI* URI
	  *stream* stream
	  *closed* should-be-closed
	  *reason* reason)
    *body*))

(defun reach-n (tree ns)
  (if (equal 1 (length ns))
      (nth (car ns) tree)
      (reach-n (nth (car ns) tree) (cdr ns))))

(defparameter *baseurl* "http://chem.nankai.edu.cn/dt.aspx?n=")
(defparameter *names*
  '(
   "A099209058"
   "A000501558"
   "A092007358"
   "A000000058"
   "A099205158"
   "A099705658"
   "A092005658"
   "A000511858"
   "A099604258"
   "A000105858"
   "A000302058"
   "A000319958"
   "A000916858"
   "A000000158"
   "A099406058"
   "A000404758"
   "A099901758"
   "A092014058"
   "A097604958"
   "A000100558"
   "A000303458"
   "A099201958"
   "A000311558"
   "A001209358"
   "A099411958"
   "A000622258"
   "A000608058"
   "A099816958"
   "A099001258"
   "A000316558"
   "A000301458"
   "A099808858"
   "A009406958"
   "A092011758"
   "A000608258"
   "A000703158"
   "A099107058"
   "A000417758"
   "A000202558"
   "A000508958"
   "A000216458"
   "A000311258"
   "A001002258"
   "A000608158"
   "A099001358"
   "A000509958"
   "A098500658"
   "A000920858"
   "A099611158"
   "A000207758"
   "A092011358"
   "A000213858"
   "A099403558"
   "A000419358"
   "A099903058"
   "A001012358"
   "A099542158"
   "A099506358"
   "A000609458"
   "A099809058"
   "A095607758"
   "A000900958"
   "A000613858"
   "A097701658"
   "A000203458"
   "A009207458"
   "A000404258"
   "A098505458"
   "A000608458"
   "A099707458"
   "A099300558"
   "A000707658"
   "A000706158"
   "A000312158"
   "A098600258"
   "A000704658"
   "A000423058"
   "A000717458"
   "A092005858"
   "A099203858"
   "A000214858"
   "A099305558"
   "A000321358"
   "A099610658"
   "A097805158"
   "A099712158"
   "A000500358"
   "A094904658"
   "A000320358"
   "A099606758"
   "A099502658"
   "A000202258"
   "A096008258"
   "A001012758"
   "A099709958"
   "A099000958"
   "A098606658"
   "A099414458"
   "A001208858"
   "A000413858"
   "A099809458"
   "A099608358"
   "A000509058"
   "A000412858"
   "A000612358"
   "A092011558"
   "A099604358"
   "A000413758"
   "A092007558"
   "A000402758"
   "A099813558"
   "A099905858"
   "A000322558"
   "A000312558"
   "A000320258"
   "A000212558"
   "A000810958"
   "A092011858"
   "A000309658"
   "A099405058"
   "A000711458"
   "A000510958"
   "A099908658"
   "A000603558"
   "A099604458"
   "A099304158"
   "A000600258"
   "A099308058"
   "A000700858"
   "A001110558"
   "A000107958"
   "A000413658"
   "A000313858"
   "A099304958"
   "A099709858"
   "A000720358"
   "A000310058"
   "A000313058"
   "A099913058"
   "A000423258"
   "A098505858"
   "A099915158"
   "A097800758"
   "A099806158"
   "A000303858"
   "A099304558"
   "A000515358"
   "A099108058"
   "A098600558"
   "A000503058"
   "A000321458"
   "A000614958"
   "A092005758"
   "A000616858"
   "A000800758"
   "A098801958"
   "A092008558"
   "A099307258"
   "A098403858"
   "A000424658"
   "A099311258"
   "A000606158"
   "A000622358"
   "A000309358"
   "A001100858"
   "A099809258"
   "A000211758"
   "A000422858"
   "A099506058"
   "A000404358"
   "A000105358"
   "A096916758"
   "A098703258"
   "A099816758"
   "A099912758"
   "A099908458"
   "A099807758"
   "A000608358"
   "A000409258"
   "A099817058"
   "A000313958"
   "A000510558"
   "A098904658"))

(defparameter *LBODY* (chtml:parse (remove #\ (get-URL (concatenate 'string *baseurl* (nth 1 names)))) (chtml:make-lhtml-builder)))

*LBODY*

(defparameter *TABLE* (reach-n *LBODY* '(3 3 2 2 2 3 2)))

(defun ognore (&rest arg))

(defconstant +head+ '("Page"
		      "姓名"
		      "性别"
		      "出生年月"
		      "籍贯"
		      "学历"
		      "职称"
		      "二级学科"
		      "所在单位"
		      "毕业院校"
		      "荣誉称号"
		      "实验地点"
		      "通讯地址"
		      "邮编"
		      "电子邮件"
		      "办公电话"
		      "个人简历"
		      "研究方向"
		      "研究成果"
		      "人才培养"))
(ognore
 (reach-n *TABLE* '(2 3 2 2))
 (reach-n *TABLE* '(2 5 2 2))
 (reach-n *TABLE* '(3 3 2 2))
 (reach-n *TABLE* '(3 5 2 2))
 (reach-n *TABLE* '(4 3 2 2))
 (reach-n *TABLE* '(4 5 2 2))
 (reach-n *TABLE* '(5 3 2 2))
 (reach-n *TABLE* '(5 5 2 2))
 (reach-n *TABLE* '(6 3 2 2))
 (reach-n *TABLE* '(7 3 2 2))
 (reach-n *TABLE* '(8 3 2 2))
 (reach-n *TABLE* '(9 3 2 2))
 (reach-n *TABLE* '(10 3 2 2))
 (reach-n *TABLE* '(10 5 2 2))
 (reach-n *TABLE* '(11 3 2 2))
 (apply #'concatenate 'string (remove-if #'listp (cddr (reach-n *TABLE* '(12 3 2)))))
 (apply #'concatenate 'string (remove-if #'listp (cddr (reach-n *TABLE* '(13 3 2)))))
 (apply #'concatenate 'string (remove-if #'listp (cddr (reach-n *TABLE* '(14 3 2)))))
 (apply #'concatenate 'string (remove-if #'listp (cddr (reach-n *TABLE* '(15 3 2))))))

(loop for str in *names* do
     (let* ((lbody (chtml:parse (remove #\ (get-URL (concatenate 'string *baseurl* str))) (chtml:make-lhtml-builder)))
	    (ltable (reach-n lbody '(3 3 2 2 2 3 2)))
	    (info (list
		   (concatenate 'string *baseurl* str)
		   (format nil "~A" (reach-n ltable '(2 3 2 2)))
		   (format nil "~A" (reach-n ltable '(2 5 2 2)))
		   (format nil "~A" (reach-n ltable '(3 3 2 2)))
		   (format nil "~A" (reach-n ltable '(3 5 2 2)))
		   (format nil "~A" (reach-n ltable '(4 3 2 2)))
		   (format nil "~A" (reach-n ltable '(4 5 2 2)))
		   (format nil "~A" (reach-n ltable '(5 3 2 2)))
		   (format nil "~A" (reach-n ltable '(5 5 2 2)))
		   (format nil "~A" (reach-n ltable '(6 3 2 2)))
		   (format nil "~A" (reach-n ltable '(7 3 2 2)))
		   (format nil "~A" (reach-n ltable '(8 3 2 2)))
		   (format nil "~A" (reach-n ltable '(9 3 2 2)))
		   (format nil "~A" (reach-n ltable '(10 3 2 2)))
		   (format nil "~A" (reach-n ltable '(10 5 2 2)))
		   (format nil "~A" (reach-n ltable '(11 3 2 2)))
		   (format nil "~A" (apply #'concatenate 'string (remove-if #'listp (cddr (reach-n ltable '(12 3 2))))))
		   (format nil "~A" (apply #'concatenate 'string (remove-if #'listp (cddr (reach-n ltable '(13 3 2))))))
		   (format nil "~A" (apply #'concatenate 'string (remove-if #'listp (cddr (reach-n ltable '(14 3 2))))))
		   (format nil "~A" (apply #'concatenate 'string (remove-if #'listp (cddr (reach-n ltable '(15 3 2)))))))))
       (with-open-file (s (concatenate 'string str ".txt")
			  :if-does-not-exist :create
			  :if-exists :overwrite
			  :direction :output)
	 (loop for str in info do
	      (progn
		(format s "~A" str))))))


