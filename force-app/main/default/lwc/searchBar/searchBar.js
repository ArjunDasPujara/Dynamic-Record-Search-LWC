import { api, LightningElement } from 'lwc';

export default class SearchBar extends LightningElement {

	@api placeholderText = '';

	handlekeyup(event) {
		const isEnterKey = event.keyCode === 13;
		if(isEnterKey && event.target.value) {
			const searchCustomEvent = new CustomEvent('search', {
				detail : {
					'searchTerm' : event.target.value
				}
			});
			this.dispatchEvent(searchCustomEvent);
		}
	}
}