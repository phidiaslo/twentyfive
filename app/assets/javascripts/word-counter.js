var wordCounter = {
	el: '.word-count',
	
	initialize: function() {
		var _this = this;
		
		$('textarea', this.el).on('change', function() { _this.update( $(this).val() ); });
		$('textarea', this.el).on('keyup',  function() { _this.update( $(this).val() ); });
	},
	
	update: function(value) {
		$('.chars', this.el).html( this.getCharCount(value) );
		$('.words', this.el).html( this.getWordCount(value.trim()) );
		$('.paras', this.el).html( this.getParaCount(value.trim()) );
	},
	
	/*
	 * getCharCount:
	 *   - Calculates the number of characters in the field.
	 *   - Counts *all* characters.
	 */
	
	getCharCount: function(value) {
		return value.length;
	},
	
	/*
	 * getWordCount:
	 *   - Calculates the number of words in the field.
	 *   - Words are separated by any number of spaces or a semi-colon.
	 */
	
	getWordCount: function(value) {
		if (value) {
			var regex = /\s+|\s*;+\s*/g;
			return value.split(regex).length;
		}
		
		return 0;
	},
	
	/*
	 * getParaCount:
	 *   - Calculates the number of paragraphs in the field.
	 *   - Paragraphs are separated by any number of newline characters.
	 */
	
	getParaCount: function(value) {
		if (value) {
			var regex = /\n+/g;
			return value.split(regex).length;
		}
		
		return 0;
	}
};

wordCounter.initialize();