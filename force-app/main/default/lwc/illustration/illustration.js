import { LightningElement, api } from 'lwc';

export default class Illustration extends LightningElement {
	@api
	errorText;

	@api
	isLinkTypeText = false;

	handleLinkClick() {
		// Dispatches the linkclick event.
		this.dispatchEvent(new CustomEvent("linkclick"));
	}

	get isLinkType() {
		return this.isLinkTypeText;
	}
}